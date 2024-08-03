import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:midjo/src/services/firebase_service.dart';
import 'package:midjo/src/states/userinfos.dart';
import 'package:provider/provider.dart';

class AccountInformations extends StatefulWidget {
  final String title;
  final String subtitle;
  final int updatetype;

  const AccountInformations({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.updatetype,
  }) : super(key: key);

  @override
  State<AccountInformations> createState() => _AccountInformationsState();
}

class _AccountInformationsState extends State<AccountInformations> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 177, 177, 177),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 160,
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Entrez votre ${widget.subtitle}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 172, 172, 172),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: CupertinoTextField(
                                controller: _textEditingController,
                                placeholder: '${widget.title}',
                                /*   placeholder: title,
                              placeholderStyle: TextStyle(
                                color: Colors.black
                              ), */

                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color(0xff7152F3),
                                ))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //   const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 55),
                                  backgroundColor:
                                      const Color.fromARGB(255, 241, 241, 241),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Annuler',
                                  style: TextStyle(
                                    color: Color(0xff7152F3),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  switch (widget.updatetype) {
                                    case 1:
                                      userDataProvider.updateUserDataNumero(
                                          _textEditingController.text);
                                      break;
                                    case 2:
                                      userDataProvider.updateUserDataNom(
                                          _textEditingController.text);
                                      break;
                                    case 3:
                                      userDataProvider.updateUserDataEmail(
                                          _textEditingController.text);
                                      break;
                                    default:
                                  }

                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 55),
                                  backgroundColor: const Color(0xff7152F3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Enregistrer',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Color(0xff7152F3),
            ),
          ),
        ],
      ),
    );
  }
}
