import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/modules/home_module/domain/models/characters_model.dart';

class DetailsView extends StatefulWidget {
  static const String name = 'details';
  final CharacterModel character;
  const DetailsView({super.key, required this.character});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool expandImage = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color colorByStatus = widget.character.status.name == 'DEAD'
        ? Colors.red.shade100
        : widget.character.status.name != 'ALIVE'
            ? Colors.grey.shade100
            : Colors.green.shade100;
    Color colorByStatusText = widget.character.status.name == 'DEAD'
        ? Colors.red
        : widget.character.status.name != 'ALIVE'
            ? Colors.grey
            : Colors.green;
    return Scaffold(
        backgroundColor: colorByStatus,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Character detail',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: colorByStatus,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expandImage = !expandImage;
                    });
                  },
                  child: CharacterImageWidget(
                      character: widget.character, expandImage: expandImage),
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(widget.character.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width / 20))),
                  Transform.rotate(
                      angle: 70,
                      child: Text(widget.character.status.name.toUpperCase(),
                          style: TextStyle(
                              color: colorByStatusText,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width / 18))),
                ],
              ),
              SizedBox(
                height: size.height / 40,
              ),
              InfoWidget(
                character: widget.character,
                size: size,
              )
            ],
          ),
        ));
  }
}

class CharacterImageWidget extends StatelessWidget {
  const CharacterImageWidget({
    super.key,
    required this.character,
    required this.expandImage,
  });

  final CharacterModel character;
  final bool expandImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Hero(
      transitionOnUserGestures: true,
      tag: character.id,
      child: Container(
          height: expandImage == true ? size.height / 1.2 : size.height / 2.5,
          decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    blurStyle: BlurStyle.solid),
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    blurStyle: BlurStyle.solid),
              ],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    character.image,
                  ), //NetworkImage(character.image),
                  fit: BoxFit.cover))),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final CharacterModel character;
  final Size size;
  const InfoWidget({super.key, required this.character, required this.size});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Colors.white60,
      surfaceTintColor: Colors.white70,
      child: Container(
        // height: size.height/10,
        width: size.width / 1.2,
        constraints: BoxConstraints(maxWidth: size.width / 1.2),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              'Character Information'.toUpperCase(),
              style: TextStyle(color: Colors.grey),
            )),
            SizedBox(
              height: size.height / 80,
            ),
            RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(text: 'Status : '),
                TextSpan(
                    text: character.status.name.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(text: 'Species : '),
                TextSpan(
                    text: character.species.name.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(text: 'Gender : '),
                TextSpan(
                    text: character.gender.name,
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(text: 'Type : '),
                TextSpan(
                    text: character.type.isEmpty
                        ? 'UNKNOWN'
                        : character.type.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(text: 'Location : '),
                TextSpan(
                    text: character.location.name.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
                TextSpan(text: 'Episodes : '),
                TextSpan(
                    text: character.episode.length.toString().toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
