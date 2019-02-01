import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gitod/src/widget/query_graphql.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';
import 'package:gitod/src/screen/code_screen.dart';

String viewTree = """
query nodeTree(\$repoId: ID!,\$path: String!) {
  repository : node(id: \$repoId) {
    ... on Repository {
      id
      name
      nameWithOwner
      defaultBranchRef {
        id
        name
      }
      object(expression: \$path) {
        ... on Tree {
          entries {
            name
            type
            object {
              ... on Blob {
                isBinary
                text
                byteSize
              }
            }
          }
        }
      }
    }
  }
}
""";

class RepoScreen extends StatefulWidget {
  final String repoId;
  final String nameWithOwner;
  final String path;
  const RepoScreen(
      {@required this.repoId,
      @required this.nameWithOwner,
      this.path = "master:"});

  @override
  State<StatefulWidget> createState() => _RepoScreenState();
}

class _RepoScreenState extends State<RepoScreen> {
  String resourcePath;
  @override
  initState() {
    super.initState();
    resourcePath = widget.path;
  }

  @override
  Widget build(BuildContext context) {
    return QueryGraphql(viewTree.replaceAll('\n', ' '),
        variables: {"repoId": widget.repoId, "path": resourcePath}, builder: ({
      bool loading,
      var data,
      Exception error,
    }) {
      final List<String> pathlist =
          resourcePath.split(':').skip(1).where((p) => p.isNotEmpty).toList();
      pathlist.insert(0, "${widget.nameWithOwner.split("/").skip(1).join()}/");
      if (loading || error != null) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.nameWithOwner),
              centerTitle: true,
            ),
            body: Center(
                child: error != null
                    ? Text(error.toString())
                    : SpinKitCubeGrid(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      )));
      }
      Repository node = Repository.fromJson(data['repository']);
      if (node.object == null) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.nameWithOwner),
              centerTitle: true,
            ),
            body: Center(child: Text("$resourcePath not found entries")));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.nameWithOwner),
          centerTitle: true,
        ),
        body: ListView.separated(
            shrinkWrap: true,
            itemCount: node.object.entries.length + 1,
            separatorBuilder: separatorBuilder,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return ListTile(
                    title: Container(
                        color: HexColor("#d0d0d0"),
                        padding: EdgeInsets.all(7),
                        height: pathlist.length == 0 ? 30 : 30,
                        child: Row(children: <Widget>[
                          Text(
                            pathlist.join(),
                            style: TextStyle(color: HexColor("#586069")),
                          ),
                        ])));
              }
              final TreeEntry entry = node.object.entries[index - 1];
              return ListTile(
                  onTap: () {
                    if (entry.isFolder) {
                      Navigator.of(context).push(MaterialPageRoute<String>(
                          builder: (context) => RepoScreen(
                                nameWithOwner: widget.nameWithOwner,
                                repoId: widget.repoId,
                                path: "$resourcePath${entry.name}/",
                              )));
                    } else if (entry.object.isBinary) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('binary file can\'t open')));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute<String>(
                          builder: (context) => CodeScreen(
                                name: entry.name,
                                text: entry.object.text,
                              )));
                    }
                  },
                  leading: Icon(entry.isFolder
                      ? Icons.folder_open
                      : Icons.insert_drive_file),
                  title: Text(entry.name));
            }),
      );
    });
  }
}
