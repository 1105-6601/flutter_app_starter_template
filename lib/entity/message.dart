import 'dart:math';
import 'package:faker/faker.dart';
import 'package:flutter_app_starter_template/parts/view/chat-user.dart';
import 'package:flutter_app_starter_template/util/mock-util.dart';

class Message
{
  final bool isImage;
  final String text;
  final String imageUrl;
  final DateTime date;
  final ChatUser user;

  Message({
    this.isImage,
    this.text,
    this.imageUrl,
    this.date,
    this.user,
  });

  /// Generate dummy messages order by date desc
  /// * First element is newest message.
  static List<Message> generateDummyMessages(List<ChatUser> availableUsers, {DateTime before})
  {
    final List<Message> messages = [];

    // Generate a dummy message
    // Set initial date
    DateTime currentDate;
    if (before == null) {
      currentDate = DateTime.now().subtract(Duration(days: 10));
    } else {
      currentDate = before.subtract(Duration(days: 10));
    }

    while (true) {

      final randomUserIndex = Faker().randomGenerator.integer(availableUsers.length);

      final isImage                      = MockUtil.select(threshold: 0.9);
      final randomImageResolutionWidth   = Faker().randomGenerator.integer(1920, min: 800);
      final randomImageResolutionHeight  = Faker().randomGenerator.integer(1920, min: 600);
      final validImageUrl                = 'https://picsum.photos/$randomImageResolutionWidth/$randomImageResolutionHeight';
      final invalidImageUrl              = 'https://i.picsum.photos/id/1/10000/10000.jpg';
      final user                         = availableUsers[randomUserIndex];

      messages.add(Message(
        isImage:  isImage,
        text:     isImage ? null : Faker().lorem.sentence(),
        imageUrl: isImage ? (MockUtil.select(threshold: 0.1) ? validImageUrl : invalidImageUrl) : null,
        date:     currentDate,
        user:     user,
      ));

      // Update date
      final randomDuration = Duration(seconds: Random().nextInt(60 * 60 * 12));
      currentDate = currentDate.add(randomDuration);

      if (before == null) {
        if (currentDate.isAfter(DateTime.now())) {
          break;
        }
      } else {
        if (currentDate.isAfter(before)) {
          break;
        }
      }
    }

    return messages.reversed.toList();
  }
}


