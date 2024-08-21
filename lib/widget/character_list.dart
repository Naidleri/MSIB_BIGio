import 'dart:async';

import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterList extends StatefulWidget {
  final List<Character> characters;
  final Function(Character) onCharacterTap;
  final Function onLoadMore;
  final bool hasMore;

  CharacterList({
    required this.characters,
    required this.onCharacterTap,
    required this.onLoadMore,
    required this.hasMore,
  });

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>
    with AutomaticKeepAliveClientMixin<CharacterList> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  bool get wantKeepAlive => true;

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.hasMore) {
          widget.onLoadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == widget.characters.length) {
                  return _buildLoadingIndicator();
                }
                final character = widget.characters[index];
                return RepaintBoundary(
                  child: GestureDetector(
                    onTap: () => widget.onCharacterTap(character),
                    child: GridTile(
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Image.network(character.imageUrl,
                            fit: BoxFit.cover),
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(character.name),
                        subtitle: Text(character.species),
                      ),
                    ),
                  ),
                );
              },
              childCount: widget.hasMore
                  ? widget.characters.length + 1
                  : widget.characters.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 6;
    if (width > 800) return 4;
    if (width > 600) return 3;
    return 2;
  }
}
