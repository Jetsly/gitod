import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/list_repo.dart';
import 'package:gitod/src/widget/query_graphql.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String viewRepo = """
query searchRepo(\$nkeyWord: String!) {
  search(query:\$nkeyWord,first:20,type:REPOSITORY){
    repositoryCount
    userCount
    issueCount
    wikiCount,
    ${PageInfo.graph}
    ${RepositoryEdge.graph}
  }
}
""";

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String keyWord = '';

  onSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      setState(() {
        keyWord = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted),
        ),
        body: keyWord.isEmpty
            ? Center(child: Text('Search Repository'))
            : QueryGraphql(viewRepo.replaceAll('\n', ' '), variables: {
                'nkeyWord': keyWord,
              }, builder: ({
                bool loading,
                var data,
                Exception error,
              }) {
                if (error != null) {
                  return Text(error.toString());
                }
                if (loading) {
                  return Center(
                      child: SpinKitCubeGrid(
                    color: Colors.blue,
                    size: 50.0,
                  ));
                }
                SearchResultItemConnection repositories =
                    SearchResultItemConnection.fromJson(data['search']);
                return ListRepoWidget(repositories: repositories.edges);
              }));
  }
}
