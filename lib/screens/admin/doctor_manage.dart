import 'package:flutter/material.dart';

import '../../data/doctor_data.dart';
import '../../models/doctor_model.dart';

class DoctorManageScreen extends StatefulWidget {
  const DoctorManageScreen({super.key});

  @override
  State<DoctorManageScreen> createState() =>
      _DoctorManageScreenState();
}

class _DoctorManageScreenState
    extends State<DoctorManageScreen> {

  final TextEditingController searchController =
      TextEditingController();

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController spesialisController =
      TextEditingController();

  final TextEditingController lokasiController =
      TextEditingController();

  final TextEditingController hargaController =
      TextEditingController();

  final TextEditingController ratingController =
      TextEditingController();

  List<DoctorModel> doctors = [];

  String keyword = "";

  @override
  void initState() {
    super.initState();

    doctors = List.from(doctorData);
  }

  @override
  Widget build(BuildContext context) {

    final filteredDoctor = doctors.where((doctor) {

      return doctor.name
          .toLowerCase()
          .contains(keyword);

    }).toList();

    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 202, 223, 255),

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: true,

        title: const Text(

          "Kelola Dokter",

          style: TextStyle(

            color: Colors.black,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

      floatingActionButton: FloatingActionButton(

        backgroundColor: const Color(0xff2F80ED),

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () {

          clearController();

          showDoctorDialog();

        },

      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(16),

            child: TextField(

              controller: searchController,

              decoration: InputDecoration(

                hintText: "Cari dokter...",

                prefixIcon: const Icon(Icons.search),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide: BorderSide.none,

                ),

              ),

              onChanged: (value) {

                setState(() {

                  keyword =
                      value.toLowerCase();

                });

              },

            ),

          ),

          Expanded(

            child: ListView.builder(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              itemCount:
                  filteredDoctor.length,

              itemBuilder:
                  (context, index) {

                final doctor =
                    filteredDoctor[index];
                                    return Card(

                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: ListTile(

                    leading: CircleAvatar(
  radius: 28,
  backgroundColor: const Color(0xffEAF3FF),

  child: ClipOval(
    child: Image.asset(
      doctor.image,
      width: 52,
      height: 52,
      fit: BoxFit.contain,
    ),
  ),
),

                    title: Text(
                      doctor.name,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      mainAxisSize:
                          MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          doctor.speciality,
                        ),

                        Text(
                          doctor.location,
                          style:
                              const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          doctor.price,
                          style: const TextStyle(
                            color:
                                Color(0xff2F80ED),
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                    trailing: Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        IconButton(

                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),

                          onPressed: () {

                            namaController.text =
                                doctor.name;

                            spesialisController
                                    .text =
                                doctor.speciality;

                            lokasiController.text =
                                doctor.location;

                            hargaController.text =
                                doctor.price;

                            ratingController.text =
                                doctor.rating;

                            showDoctorDialog(
                              doctor: doctor,
                              index: index,
                            );

                          },

                        ),

                        IconButton(

                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),

                          onPressed: () {

                            showDialog(

                              context: context,

                              builder: (_) =>
                                  AlertDialog(

                                title: const Text(
                                  "Hapus Dokter",
                                ),

                                content: Text(
                                  "Yakin ingin menghapus ${doctor.name} ?",
                                ),

                                actions: [

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(
                                          context);

                                    },

                                    child:
                                        const Text(
                                      "Batal",
                                    ),

                                  ),

                                  ElevatedButton(

                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red,
                                    ),

                                    onPressed: () {

                                      setState(() {

                                        doctors
                                            .removeAt(
                                                index);

                                      });

                                      Navigator.pop(
                                          context);

                                    },

                                    child:
                                        const Text(
                                      "Hapus",
                                      style:
                                          TextStyle(
                                        color: Colors
                                            .white,
                                      ),
                                    ),

                                  ),

                                ],

                              ),

                            );

                          },

                        ),

                      ],

                    ),

                  ),

                );

              },

            ),

          ),

        ],

      ),

    );

  }
  void showDoctorDialog({
  DoctorModel? doctor,
  int? index,
}) {

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        title: Text(
          doctor == null
              ? "Tambah Dokter"
              : "Edit Dokter",
        ),

        content: SingleChildScrollView(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Dokter",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: spesialisController,
                decoration: const InputDecoration(
                  labelText: "Spesialis",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: lokasiController,
                decoration: const InputDecoration(
                  labelText: "Lokasi",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: hargaController,
                decoration: const InputDecoration(
                  labelText: "Harga",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: ratingController,
                decoration: const InputDecoration(
                  labelText: "Rating",
                ),
              ),

            ],

          ),

        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

            },

            child: const Text("Batal"),

          ),

          ElevatedButton(

            onPressed: () {

              final newDoctor = DoctorModel(

                image: doctor?.image ??
                    "assets/images/doctor1.png",

                name: namaController.text,

                speciality:
                    spesialisController.text,

                rating: ratingController.text,

                price: hargaController.text,

                schedule:
                    doctor?.schedule ??
                        "08.00 - 16.00",

                about:
                    doctor?.about ??
                        "Dokter baru.",

                experience:
                    doctor?.experience ??
                        "1 Tahun",

                patients:
                    doctor?.patients ??
                        "0+",

                location:
                    lokasiController.text,

                category:
                    spesialisController.text,

              );

              setState(() {

                if (doctor == null) {

                  doctors.add(newDoctor);

                } else {

                  doctors[index!] = newDoctor;

                }

              });

              clearController();

              Navigator.pop(context);

            },

            child: const Text("Simpan"),

          ),

        ],

      );

    },

  );

}

void clearController() {

  namaController.clear();

  spesialisController.clear();

  lokasiController.clear();

  hargaController.clear();

  ratingController.clear();

}

@override
void dispose() {

  searchController.dispose();

  namaController.dispose();

  spesialisController.dispose();

  lokasiController.dispose();

  hargaController.dispose();

  ratingController.dispose();

  super.dispose();

}
}