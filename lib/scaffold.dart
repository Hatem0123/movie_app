/*

Scaffold(
        backgroundColor: Colors.black26,
        body: FutureBuilder(
            future: _movieDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
              } else {
                return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => Home_screen()), (route) => false
                          ),
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white
                      ),
                      backgroundColor: Colors.black,
                      expandedHeight: MediaQuery.of(context).size.height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: MovieTrailer.isNotEmpty
                            ? trailerwatch(MovieTrailer[0]['key'])
                            : Center(child: Text("No Trailer Available", style: TextStyle(color: Colors.white))),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              Moviedetails.isNotEmpty ? Moviedetails[0]['overview'] : "Loading...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          UserReviews.isNotEmpty
                              ? UserReview(UserReviews)
                              : Center(child: Text("No Reviews Available", style: TextStyle(color: Colors.white))),
                          similarMovieList.isNotEmpty?  slider_list(similarMovieList, "Similar Movies", "movie", similarMovieList.length)
                              :Center(child: Text("NoSimilar Movies Available", style: TextStyle(color: Colors.white))),

                          recomendedMovieList.isNotEmpty?   slider_list(recomendedMovieList, "Recommended Movies", "movie", recomendedMovieList.length)
                              : Center(child: Text("no Recomended Movies Available", style: TextStyle(color: Colors.white))),



                          //slider_list(recomendedMovieList, "Recommended Movies", "movie", recomendedMovieList.length),
                        ])
                    )
                  ],
                );
              }
            }
        )
    );


 */