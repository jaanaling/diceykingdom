import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/src/feature/game/model/user.dart';
import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:dicey_quests/ui_kit/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedGame;
  String? selectedStatus;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            List<String> gameList =
                state.game.map((game) => game.name).toList();
            List<String> statusList =
                UserStatus.values.map((status) => status.name).toList();

            return SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: nameController,
                        height: 52,
                        textSize: 12,
                        onSaved: (newValue) => nameController.text = newValue!,
                        placeholder: "fild name",
                        validator: (value) => value == null || value.isEmpty
                            ? 'Name can\'t be empty'
                            : null,
                      ),
                      AppTextField(
                        controller: descriptionController,
                        height: 230,
                        textSize: 12,
                        maxLine: 10,
                        onSaved: (newValue) =>
                            descriptionController.text = newValue!,
                        placeholder: "fild description",
                        validator: (value) => value == null || value.isEmpty
                            ? 'Description can\'t be empty'
                            : null,
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppButton(
                            width: MediaQuery.of(context).size.width * 0.45,
                            color: ButtonColors.green,
                            widget: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                (selectedGame as String?) ?? "Select game",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: CupertinoPicker(
                                        backgroundColor: Colors.white,
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedGame =
                                                gameList.elementAt(index);
                                          });
                                        },
                                        children: gameList
                                            .map((option) => Text(option))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              setState(() {
                                                selectedGame = null;
                                                context.pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AppButton(
                            width: MediaQuery.of(context).size.width * 0.45,
                            color: ButtonColors.orange,
                            widget: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                (selectedStatus as String?) ?? "Select status",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: CupertinoPicker(
                                        backgroundColor: Colors.white,
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedStatus =
                                                statusList.elementAt(index);
                                          });
                                        },
                                        children: statusList
                                            .map((option) => Text(option))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              setState(() {
                                                selectedStatus = null;
                                                context.pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Gap(16),
                      AppButton(
                        color: ButtonColors.green,
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          _formKey.currentState!.save();
                          if (nameController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty &&
                              selectedGame != null &&
                              selectedStatus != null) {
                            final newUser = User(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: nameController.text,
                              description: descriptionController.text,
                              boardGame: selectedGame!,
                              status: UserStatus.values
                                  .firstWhere((e) => e.name == selectedStatus!),
                              date: DateTime.now(),
                            );
                            context.read<GameBloc>().add(SaveUser(newUser));
                            context.pop();
                          }
                        },
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 16),
                          child: const Text(
                            'Save',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Jellee',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is GameLoading) {}
          if (state is GameError) {}
          return Column(
            children: [
              const Placeholder(),
            ],
          );
        },
      ),
    );
  }
}
