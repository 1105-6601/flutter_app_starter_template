import 'package:flutter/cupertino.dart';
import 'package:flutter_app_starter_template/parts/view/stacked-card.dart';

class StackedCardSet
{
  final List<StackedCard> cards;

  int _currentCardIndex = 0;

  StackedCardSet({
    @required this.cards,
  });

  void incrementCardIndex()
  {
    _currentCardIndex = _currentCardIndex < cards.length - 1 ? _currentCardIndex + 1 : 0;
  }

  StackedCard getFirstCard()
  {
    return cards[_currentCardIndex];
  }

  StackedCard getNextCard()
  {
    return _currentCardIndex < cards.length - 1 ? cards[_currentCardIndex + 1] : cards[0];
  }

  String getKey()
  {
    return getFirstCard().title;
  }
}
