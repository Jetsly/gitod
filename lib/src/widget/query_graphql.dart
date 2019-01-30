import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:gitod/src/models/oauth.dart';
import 'package:gitod/src/models/event_bus.dart';
import 'package:graphql_flutter/src/client.dart';
import 'package:graphql_flutter/src/widgets/graphql_provider.dart';

typedef Widget QueryBuilder({
  @required bool loading,
  Map<String, dynamic> data,
  Exception error,
});

class QueryGraphql extends StatefulWidget {
  QueryGraphql(
    this.query, {
    final Key key,
    this.variables = const {},
    @required this.builder,
    this.pollInterval,
  }) : super(key: key);

  final String query;
  final Map<String, dynamic> variables;
  final QueryBuilder builder;
  final int pollInterval;

  @override
  QueryGraphqlState createState() => QueryGraphqlState();
}

class QueryGraphqlState extends State<QueryGraphql> {
  Client client;

  bool loading = true;
  Map<String, dynamic> data = {};
  Exception error;

  bool initialFetch = true;
  Duration pollInterval;
  Timer pollTimer;
  Map currentVariables = Map();

  @override
  void initState() {
    super.initState();

    if (widget.pollInterval is int) {
      pollInterval = Duration(seconds: widget.pollInterval);
    }
  }

  @override
  void didChangeDependencies() {
    /// Gets the client from the closest wrapping [GraphqlProvider].
    client = GraphqlProvider.of(context).value;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _deleteTimer();

    super.dispose();
  }

  void _deleteTimer() {
    if (pollTimer is Timer) {
      pollTimer.cancel();
      pollTimer = null;
    }
  }

  void getQueryResult() async {
    assert(client != null);

    try {
      final Map<String, dynamic> result = client.readQuery(
        query: widget.query,
        variables: widget.variables,
      );

      if (this.mounted) {
        setState(() {
          data = result;
          error = null;
          loading = false;
        });
      }
    } catch (e) {
      // Ignore, right?
    }

    try {
      final Map<String, dynamic> result = await client.query(
        query: widget.query,
        variables: widget.variables,
      );

      if (this.mounted) {
        setState(() {
          data = result;
          error = null;
          loading = false;
        });
      }
    } catch (e) {
      if (e is http.ClientException) {
        if (e.message.contains("401 Unauthorized")) {
           EventBus.getInstance().fire(e.message);
        }
      }
      if (this.mounted) {
        setState(() {
          error = e;
          loading = false;
        });
      }
    }

    if (pollInterval is Duration && !(pollTimer is Timer)) {
      pollTimer = Timer.periodic(
        pollInterval,
        (Timer t) => getQueryResult(),
      );
    }
  }

  bool _areDifferentMaps(Map a, Map b) {
    if (a.length != b.length) {
      return true;
    }

    bool areDifferent = false;

    a.forEach((key, value) {
      if (b[key] != a[key] || (!b.containsKey(key))) {
        areDifferent = true;
      }
    });

    return areDifferent;
  }

  Widget build(BuildContext context) {
    if (initialFetch) {
      initialFetch = false;
      currentVariables = widget.variables;

      getQueryResult();
    }

    if (_areDifferentMaps(currentVariables, widget.variables)) {
      currentVariables = widget.variables;

      loading = true;
      _deleteTimer();

      getQueryResult();
    }

    return widget.builder(
      loading: loading,
      error: error,
      data: data,
    );
  }
}
