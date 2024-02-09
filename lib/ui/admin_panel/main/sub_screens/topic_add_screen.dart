import 'package:flutter/material.dart';
import 'package:new_quiz_app/models/topic_model.dart';
import 'package:new_quiz_app/providers/topic_provider.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_button.dart';
import 'package:new_quiz_app/ui/auth/widgets/global_text_field.dart';
import 'package:provider/provider.dart';

class TopicAddScreen extends StatefulWidget {
  const TopicAddScreen({super.key, this.topicModel});

  final TopicModel? topicModel;

  @override
  State<TopicAddScreen> createState() => _TopicAddScreenState();
}

class _TopicAddScreenState extends State<TopicAddScreen> {
  @override
  void initState() {
    if (widget.topicModel != null) {
      context.read<TopicProvider>().setInitialValues(widget.topicModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicModel == null ? "Topic Add" : "Topic Update"),
        leading: IconButton(
          onPressed: () {
            Provider.of<TopicProvider>(context, listen: false).clearTexts();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GlobalTextField(
                  hintText: 'Name',
                  controller: context.read<TopicProvider>().topicNameController,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 200,
                child: GlobalTextField(
                  maxLine: 100,
                  hintText: 'Description',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<TopicProvider>().topicDescController,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GlobalButton(title: widget.topicModel == null ? "Add Topics":"Update Topics", onTap:(){

                if(widget.topicModel == null){
                  context.read<TopicProvider>().addTopic(context: context);
                }
                  else{
                    context.read<TopicProvider>().updateTopic(context: context, currentTopic: widget.topicModel!);
                }
              })
            ],
          ))
        ],
      ),
    );
  }
}
