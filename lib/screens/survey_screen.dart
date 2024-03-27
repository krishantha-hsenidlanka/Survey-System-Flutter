import 'package:flutter/material.dart';
import 'package:survey_system_mobile/screens/web_view_screen.dart';
import 'package:survey_system_mobile/widgets/app_layout.dart';
import 'package:survey_system_mobile/widgets/survey_element.dart';
import 'package:survey_system_mobile/models/survey.dart';
import 'package:survey_system_mobile/services/api_service.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Survey>> _futureSurveys;
  final ScrollController _scrollController = ScrollController();
  List<Survey> _surveys = [];
  int _currentPage = 0;
  double _previousScrollOffset = 0.0;
  bool _isLoading = false;
  bool _hasMoreSurveys = true;
  @override
  void initState() {
    super.initState();
    _futureSurveys = _apiService.fetchSurveys(page: _currentPage, size: 5);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshSurveys() async {
    setState(() {
      _currentPage = 0;
      _hasMoreSurveys = true;
      _futureSurveys = _apiService.fetchSurveys(page: _currentPage, size: 5);
    });
  }

  Future<void> _loadMoreSurveys() async {
    _previousScrollOffset = _scrollController.offset;

    // setState(() {
    //   _isLoading = true;
    // });

    try {
      final newSurveys =
          await _apiService.fetchSurveys(page: _currentPage + 1, size: 5);
      setState(() {
        if (newSurveys.isEmpty) {
          _hasMoreSurveys = false;
        } else {
          _surveys.addAll(newSurveys);
          _currentPage++;
          _isLoading = false;
          _scrollController.jumpTo(_previousScrollOffset);
        }
      });
    } catch (e) {
      _hasMoreSurveys = false;
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!_isLoading && _hasMoreSurveys) {
        _loadMoreSurveys();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'My Surveys',
      backButton: false,
      currentIndex: 1,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 2:
            Navigator.pushNamed(context, '/responses');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      child: RefreshIndicator(
        onRefresh: _refreshSurveys,
        child: FutureBuilder<List<Survey>>(
          future: _futureSurveys,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting and refreshing');
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(214, 33, 47, 243),
              ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('No surveys yet!',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)));
            } else {
              _surveys = snapshot.data!;
              if (_surveys.isEmpty) {
                return Center(
                  child: Text('No surveys yet'),
                );
              } else {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: _surveys.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _surveys.length) {
                      final survey = _surveys[index];
                      return SurveyElement(
                        icon: Icons.description,
                        title: survey.title,
                        onViewPressed: () {
                          navigateToWebView(context,
                              'https://aisurvey.netlify.app/survey/${survey.id}');
                        },
                        onEditPressed: () {
                          navigateToWebView(context,
                              'https://aisurvey.netlify.app/survey/edit/${survey.id}');
                        },
                        onAnalyticsPressed: () {
                          navigateToWebView(context,
                              'https://aisurvey.netlify.app/responses/${survey.id}');
                        },
                        onDeletePressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this survey?'), // Add 'const' keyword
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await _apiService
                                            .deleteSurvey(survey.id);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Survey deleted successfully.'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        setState(() {
                                          _surveys.removeAt(index);
                                        });
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Failed to delete survey.'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    } else if (_isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox();
                    }
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
