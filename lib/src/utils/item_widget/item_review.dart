import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../entities/reviews_model.dart';
import '../custom_widget/custom_text.dart';

class ItemReview extends StatelessWidget {
  final Reviews? review;
  const ItemReview({Key? key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          CustomText(
            review?.customer?.name,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              RatingBarIndicator(
                itemBuilder: (BuildContext context,
                    int index) =>
                const Icon(
                  Icons.star,
                  color: yalowColor,
                ),
                rating: review?.rating ?? 0.0,
                itemSize: 20,
              ),
              const Spacer(),
              CustomText(
                DateFormat('MMMM d, y hh:mm a').format(DateTime.parse(review?.createdAt ?? '')),
                fontSize: 9,
                color: Colors.grey,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            review?.comment,
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
