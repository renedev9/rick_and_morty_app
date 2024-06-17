import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/home_bloc.dart';

class FilterAlertDialog extends StatefulWidget {
  final BuildContext dialogContext;
  final void Function() clearFunction;
  const FilterAlertDialog({
    super.key,
    required this.dialogContext,
    required this.clearFunction,
  });

  @override
  State<FilterAlertDialog> createState() => _FilterAlertDialogState();
}

class _FilterAlertDialogState extends State<FilterAlertDialog> {
  FocusNode myFocusNode = FocusNode();
  String selectedStatus = 'None';
  String selectedSpecies = 'None';
  String selectedGender = 'None';
  TextEditingController controller = TextEditingController();
  bool showStatus = false;
  bool showSpecies = false;
  bool showGender = false;
  bool showName = false;
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final ColorScheme colors = Theme.of(context).colorScheme;
    String title = showName
        ? 'Oh, a name?'
        : showGender
            ? 'Oh a gender?'
            : showSpecies
                ? 'Oh, you\'re looking for some race'
                : showStatus
                    ? ' I\'m alive don\'t look for another state'
                    : 'You\'re looking for something';
    return Builder(
      builder: (dialogContext) {
        return AlertDialog(
          scrollable: true,
          title: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          )),
          backgroundColor: colors.primary,
          content: showStatus == true
              ? _buildStatusList()
              : showSpecies == true
                  ? _buildSpeciesList()
                  : showGender == true
                      ? _buildGenderList()
                      : showName == true
                          ? _buildShowForm(myFocusNode)
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RowFormWidget(
                                  textLeading: 'Name: ',
                                  function: () {
                                    setState(() {
                                      showName = true;
                                    });
                                  },
                                  textForm: controller.text.isEmpty
                                      ? 'None'
                                      : controller.text,
                                ),
                                RowFormWidget(
                                    textLeading: 'Status: ',
                                    function: () {
                                      setState(() {
                                        showStatus = true;
                                      });
                                    },
                                    textForm: selectedStatus),
                                RowFormWidget(
                                    textLeading: 'Species: ',
                                    function: () {
                                      setState(() {
                                        showSpecies = true;
                                      });
                                    },
                                    textForm: selectedSpecies),
                                RowFormWidget(
                                    textLeading: 'Gender: ',
                                    function: () {
                                      setState(() {
                                        showGender = true;
                                      });
                                    },
                                    textForm: selectedGender),
                              ],
                            ),
          actionsAlignment: MainAxisAlignment.center,
          actions: showName == true
              ? [
                  DynamicButton(
                    text: 'Ok',
                    dynamicFunction: () {
                      setState(() {
                        showName = false;
                      });
                    },
                  ),
                ]
              : [
                  AcceptButton(
                    acceptFunction: () {
                      if (controller.text.isNotEmpty ||
                          selectedStatus != 'None' ||
                          selectedGender != 'None' ||
                          selectedSpecies != 'None') {
                        context.read<HomeBloc>().add(FilterCharactersEvent(
                            name: controller.text.replaceAll(' ', ''),
                            status: selectedStatus.replaceAll('None', ''),
                            gender: selectedGender.replaceAll('None', ''),
                            species: selectedSpecies.replaceAll('None', ''),
                            initialPaginate: true));
                      }
                      context.pop();
                    },
                  ),
                  /* TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty ||
                      selectedStatus != 'None' ||
                      selectedGender != 'None' ||
                      selectedSpecies != 'None') {
                    context.read<HomeBloc>().add(FilterCharactersEvent(
                        name: controller.text.replaceAll(' ', ''),
                        status: selectedStatus.replaceAll('None', ''),
                        gender: selectedGender.replaceAll('None', ''),
                        species: selectedSpecies.replaceAll('None', ''),
                        initialPaginate: true));
                  }
                  context.pop();
                },
                child: Text('ACCEPT')), */
                  ClearButton(
                    clearFunction: widget.clearFunction,
                  ),
                  /* TextButton(
                      onPressed: widget.clearFunction
                      /* () {
                  context.pop();
                  context.read<HomeBloc>().add(const LoadCharactersEvent());
                } */
                      ,
                      child: Text('CLEAR')) */
                ],
        );
      },
    );
  }

  Widget _buildStatusList() {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("None"),
              value: "None",
              groupValue: selectedStatus,
              onChanged: (String? value) {
                setState(() {
                  selectedStatus = value!;
                  showStatus = false;
                });
              },
            );
          case 1:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Alive",style: TextStyle(fontWeight: selectedStatus=='Alive'?FontWeight.bold:FontWeight.normal),),
              value: "Alive",
              groupValue: selectedStatus,
              onChanged: (String? value) {
                setState(() {
                  selectedStatus = value!;
                  showStatus = false;
                });
              },
            );
          case 2:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Dead",style: TextStyle(fontWeight: selectedStatus=='Dead'?FontWeight.bold:FontWeight.normal),),
              value: "Dead",
              groupValue: selectedStatus,
              onChanged: (String? value) {
                setState(() {
                  selectedStatus = value!;
                  showStatus = false;
                });
              },
            );
          case 3:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Unknown",style: TextStyle(fontWeight: selectedStatus=='Unknown'?FontWeight.bold:FontWeight.normal),),
              value: "Unknown",
              groupValue: selectedStatus,
              onChanged: (String? value) {
                setState(() {
                  selectedStatus = value!;
                  showStatus = false;
                });
              },
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildSpeciesList() {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("None",style: TextStyle(fontWeight: selectedSpecies=='None'?FontWeight.bold:FontWeight.normal),),
              value: "None",
              groupValue: selectedSpecies,
              onChanged: (String? value) {
                setState(() {
                  selectedSpecies = value!;
                  showSpecies = false;
                });
              },
            );
          case 1:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Humanoid",style: TextStyle(fontWeight: selectedSpecies=='Humanoid'?FontWeight.bold:FontWeight.normal),),
              value: "Humanoid",
              groupValue: selectedSpecies,
              onChanged: (String? value) {
                setState(() {
                  selectedSpecies = value!;
                  showSpecies = false;
                });
              },
            );

          case 2:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Human",style: TextStyle(fontWeight: selectedSpecies=='Human'?FontWeight.bold:FontWeight.normal)),
              value: "Human",
              groupValue: selectedSpecies,
              onChanged: (String? value) {
                setState(() {
                  selectedSpecies = value!;
                  showSpecies = false;
                });
              },
            );
          case 3:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Alien",style: TextStyle(fontWeight: selectedSpecies=='Alien'?FontWeight.bold:FontWeight.normal)),
              value: "Alien",
              groupValue: selectedSpecies,
              onChanged: (String? value) {
                setState(() {
                  selectedSpecies = value!;
                  showSpecies = false;
                });
              },
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildGenderList() {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("None",style: TextStyle(fontWeight: selectedGender=='None'?FontWeight.bold:FontWeight.normal)),
              value: "None",
              groupValue: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value!;
                  showGender = false;
                });
              },
            );
          case 1:
            return RadioListTile<String>(
              activeColor: colors.secondary,
              title: Text("Female",style: TextStyle(fontWeight: selectedGender=='Female'?FontWeight.bold:FontWeight.normal)),
              value: "Female",
              groupValue: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value!;
                  showGender = false;
                });
              },
            );
          case 2:
            return RadioListTile<String>(
              activeColor:  colors.secondary,
              title: Text("Male",style: TextStyle(fontWeight: selectedGender=='Male'?FontWeight.bold:FontWeight.normal)),
              value: "Male",
              groupValue: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value!;
                  showGender = false;
                });
              },
            );
          case 3:
            return RadioListTile<String>(
              activeColor:  colors.secondary,
              title: Text("Genderless",style: TextStyle(fontWeight: selectedGender=='Genderless'?FontWeight.bold:FontWeight.normal)),
              value: "Genderless",
              groupValue: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value!;
                  showGender = false;
                });
              },
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildShowForm(FocusNode focusNode) {
    return TextFormField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));
  }
}

class RowFormWidget extends StatefulWidget {
  final String textLeading;
  final void Function()? function;
  final String textForm;
  const RowFormWidget(
      {super.key,
      required this.textLeading,
      this.function,
      required this.textForm});

  @override
  State<RowFormWidget> createState() => _RowFormWidgetState();
}

class _RowFormWidgetState extends State<RowFormWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          widget.textLeading,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        SizedBox(
          width: size.width / 20,
        ),
        TextButton(
            onPressed: widget.function,
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: colors.secondary,
                    ),
                    borderRadius: BorderRadius.circular(10))),
            child: Text(
              widget.textForm,
              style: TextStyle(
                  color: widget.textForm == 'None' ? Colors.grey : colors.secondary,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class AcceptButton extends StatelessWidget {
  final void Function()? acceptFunction;
  const AcceptButton({super.key, this.acceptFunction});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: acceptFunction,
      child: Text(
        'Accept',
        style: TextStyle(color: colors.secondary),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.secondary),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}

class ClearButton extends StatelessWidget {
  final void Function()? clearFunction;
  const ClearButton({super.key, this.clearFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: clearFunction,
      child: Text(
        'Clear',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}

class DynamicButton extends StatelessWidget {
  final String text;
  final void Function()? dynamicFunction;
  const DynamicButton({super.key, this.dynamicFunction, required this.text});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: dynamicFunction,
      child: Text(
        text,
        style: TextStyle(color: colors.secondary),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.secondary),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
