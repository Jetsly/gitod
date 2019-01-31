import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/list_repo.dart';
import 'package:gitod/src/widget/query_graphql.dart';

String viewRepo = """
query searchRepo(\$nkeyWord: String!) {
  search(query:\$nkeyWord,first:10,type:REPOSITORY){
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
  bool searchIng = true;
  String keyWord = '';

  onSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      setState(() {
        searchIng = false;
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
        body: searchIng
            ? Text('search')
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
                  return Text(
                    'Loading Repo',
                  );
                }
                SearchResultItemConnection repositories =
                    SearchResultItemConnection.fromJson(data['search']);
                return ListRepoWidget(repositories: repositories.edges);
              }));
  }
}
