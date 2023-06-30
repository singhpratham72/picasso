import 'package:flutter/material.dart';
import 'package:picasso/models/photo_model.dart';

class PhotoDetailsScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailsScreen({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          photo.alt ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    photo.src?.large ?? '',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Photographer: ${photo.photographer ?? ''}',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Photo URL:',
                    style: TextStyle(fontSize: 16.0, color: Colors.purple),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    photo.url ?? '',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 16.0, color: Colors.purple),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sollicitudin ullamcorper tellus et luctus. Morbi pulvinar metus ante, eu luctus risus pretium id. Maecenas interdum turpis a elit suscipit, vel elementum leo fringilla. Aenean ullamcorper nunc ac augue molestie, tristique placerat magna viverra.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
