import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/home_bloc.dart';

class FilterAlertDialog extends StatefulWidget {
  final BuildContext dialogContext;
  final void Function() clearFunction;
  const FilterAlertDialog({
    super.key,
    required this.dialogContext, required this.clearFunction,
  });

  @override
  State<FilterAlertDialog> createState() => _FilterAlertDialogState();
}

class _FilterAlertDialogState extends State<FilterAlertDialog> {
  String selectedStatus = 'None';
  String selectedSpecies = 'None';
  String selectedGender = 'None';
  TextEditingController controller = TextEditingController();
  bool showStatus = false;
  bool showSpecies = false;
  bool showGender = false;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (dialogContext) {
        return AlertDialog(
          scrollable: true,
          title: Text('Filter'),
          content: showStatus == true
              ? _buildStatusList()
              : showSpecies == true
                  ? _buildSpeciesList()
                  : showGender == true
                      ? _buildGenderList()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                  label: Text('Name: '),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                            Row(
                              children: [
                                Text('Status: '),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showStatus = true;
                                      });
                                    },
                                    child: Text(selectedStatus))
                              ],
                            ),
                            Row(
                              children: [
                                Text('Species: '),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showSpecies = true;
                                      });
                                    },
                                    child: Text(selectedSpecies))
                              ],
                            ),
                            Row(
                              children: [
                                Text('Gender: '),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showGender = true;
                                      });
                                    },
                                    child: Text(selectedGender))
                              ],
                            )
                          ],
                        ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                onPressed: () {
                  if(controller.text.isNotEmpty|| selectedStatus!='None'||selectedGender!='None'||selectedSpecies!='None'){
                  
                  context.read<HomeBloc>().add(FilterCharactersEvent(
                      name: controller.text.replaceAll(' ', ''), 
                      status: selectedStatus.replaceAll('None', ''),
                      gender: selectedGender.replaceAll('None', ''),
                      species: selectedSpecies.replaceAll('None', ''),
                      initialPaginate: true
                      ));
                  }
                  context.pop();
                },
                child: Text('ACCEPT')),
            TextButton(
                onPressed: widget.clearFunction
                /* () {
                  context.pop();
                  context.read<HomeBloc>().add(const LoadCharactersEvent());
                } */,
                child: Text('CLEAR'))
          ],
        );
      },
    );
  }

  Widget _buildStatusList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return RadioListTile<String>(
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
              title: Text("Alive"),
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
              title: Text("Dead"),
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
              title: Text("Unknown"),
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
           case 0:
            return RadioListTile<String>(
              title: Text("None"),
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
              title: Text("Humanoid"),
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
              title: Text("Human"),
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
              title: Text("Alien"),
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return RadioListTile<String>(
              title: Text("None"),
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
              title: Text("Female"),
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
              title: Text("Male"),
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
              title: Text("Genderless"),
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
}