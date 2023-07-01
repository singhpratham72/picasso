import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picasso/cubit/search_result_cubit.dart';
import 'package:picasso/cubit/search_result_state.dart';
import 'package:picasso/models/photo_model.dart';
import 'package:picasso/screens/photo_details_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late TextEditingController _searchController;
  List<Photo> results = [];
  int pageNumber = 1;
  bool isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: '');
    searchImages(pageNumber);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> searchImages(int page) async {
    String query =
        _searchController.text.isEmpty ? 'abstract' : _searchController.text;
    final pexelsProvider =
        BlocProvider.of<SearchResultCubit>(context, listen: false);
    await pexelsProvider.getSearchResult(query: query, page: page, perPage: 40);
    final newResults =
        (pexelsProvider.state as LoadedState).searchResult.photos ?? [];
    setState(() {
      if (page == 1) {
        results = newResults;
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      } else {
        results.addAll(newResults);
      }
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      _searchController.text = query;
    });
    searchImages(1);
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> loadMoreResults() async {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      pageNumber++;
      await searchImages(pageNumber);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 72.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.purple,
          // statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: TextField(
            controller: _searchController,
            onSubmitted: (_) {
              searchImages(1);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  searchImages(1);
                },
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                ActionChip(
                  label: const Text('Paintings'),
                  onPressed: () {
                    updateSearchQuery('paintings');
                  },
                ),
                ActionChip(
                  label: const Text('Sculptures'),
                  onPressed: () {
                    updateSearchQuery('sculptures');
                  },
                ),
                ActionChip(
                  label: const Text('Photographs'),
                  onPressed: () {
                    updateSearchQuery('photographs');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchResultCubit, SearchResultState>(
              builder: (context, state) {
                if (results.isNotEmpty) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollEndNotification &&
                          scrollNotification.metrics.extentAfter == 0) {
                        loadMoreResults();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        bottom: 24.0,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: results.length + 2,
                      itemBuilder: (context, index) {
                        if (index == results.length ||
                            index == results.length + 1) {
                          if (state is LoadingState) {
                            return const Center(
                              child: SizedBox(
                                  width: 48.0,
                                  child: LinearProgressIndicator()),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        } else {
                          final photo = results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoDetailsScreen(photo: photo),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(photo.src?.medium ?? ''),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                } else if (results.isEmpty && state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text("There was some error."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
