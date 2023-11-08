import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woofpedia/models/dog.dart';
import 'package:woofpedia/state/home_state.dart';
import 'package:woofpedia/widgets/base_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    // do any setup for state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BaseWidget<HomeState>(
            state: Provider.of<HomeState>(context),
            onStateReady: (state) {
              state.getBreeds();
            },
            builder: (context, state, child) {
              return Scaffold(
                // Create your layout here
                bottomNavigationBar: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            icon: Icon(currentPage == 0
                                ? Icons.home
                                : Icons.home_outlined)),
                        const SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            icon: Icon(currentPage == 1
                                ? Icons.bookmark
                                : Icons.bookmark_outline_rounded))
                      ]),
                ),
                body: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    state.filter("");
                    setState(() {
                      currentPage = value;
                    });
                  },
                  children: [
                    //Home Page
                    Column(children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Center(
                          child: Text("Woofpedia",
                              style: TextStyle(fontSize: 30))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onSubmitted: (value) {
                            state.filter(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: state.breeds.isEmpty
                            ? state.errorGettingBreeds
                                ? const Center(
                                    child: Text("Error Getting Breeds"))
                                : const Center(
                                    child: CircularProgressIndicator())
                            : ListView(children: [
                                for (Dog breed in state.filteredBreeds.isEmpty
                                    ? state.breeds
                                    : state.filteredBreeds)
                                  ListTile(
                                    title: Text(breed.breedName,
                                        style: const TextStyle(fontSize: 20)),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(builder:
                                                (context, alertSetState) {
                                              return AlertDialog(
                                                title: Text(breed.breedName),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Temperament: ${breed.temperament}",
                                                      maxLines: null,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Image.network(
                                                              "https://cdn2.thedogapi.com/images/${breed.imageId}.jpg"),
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        const Column(
                                                          children: [
                                                            Text("Weight: xxx"),
                                                            Text("Height: xxx"),
                                                            Text(
                                                                "Life Span: xxx")
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      child: Text(state
                                                              .favouriteBreeds
                                                              .contains(breed)
                                                          ? "Saved"
                                                          : "Save To Favs"),
                                                      onTap: () {
                                                        state.saveToFavourites(
                                                            breed);
                                                        alertSetState(() {});
                                                      },
                                                    )
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("Close"))
                                                ],
                                              );
                                            });
                                          });
                                    },
                                  )
                              ]),
                      )
                    ]),
                    //Page 2
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Favourites",
                            style: TextStyle(fontSize: 30)),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: state.favouriteBreeds.isEmpty
                              ? const Center(
                                  child: Text("No Favourites Selected"))
                              : ListView(children: [
                                  for (Dog breed in state.favouriteBreeds)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(breed.breedName,
                                                      style: const TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  IconButton(
                                                      onPressed: () {
                                                        state
                                                            .removeFromFavourites(
                                                                breed);
                                                      },
                                                      icon: const Icon(
                                                          Icons.bookmark,
                                                          color: Colors.green))
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(breed.temperament,
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: Image.network(
                                                        "https://cdn2.thedogapi.com/images/${breed.imageId}.jpg"),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    children: [
                                                      const Text("Weight: xxx"),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              "./assets/Vector.svg"),
                                                          const SizedBox(
                                                              width: 5),
                                                          const Text(
                                                              "Height: xxx"),
                                                        ],
                                                      ),
                                                      const Text(
                                                          "Life Span: xxx")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                    )
                                ]),
                        )
                      ]),
                    )
                  ],
                ),
              );
            }));
  }
}
