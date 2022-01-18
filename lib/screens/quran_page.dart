import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/cubit/quran_cubit.dart';
import 'package:state_cubit/models/quran_model.dart';
import 'package:state_cubit/shared/theme.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuranCubit>(context).loadQuran();

    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            child: Center(
              child: Text(
                "Urutan Surah Al-Quran",
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(child: listSurah())
        ]),
      )),
    );
  }

  Widget listSurah() {
    return BlocBuilder<QuranCubit, QuranState>(builder: (context, state) {
      if (state is QuranLoading) {
        return _loadingIndicator();
      }
      List<Quran> quran = [];
      bool isLoading = false;

      if (state is QuranLoading) {
        quran = state.quranLoading;
        isLoading = true;
      } else if (state is QuranFetched) {
        quran = state.quranFetched!;
      }

      return ListView.builder(
          itemCount: quran.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < quran.length) {
              return _qurans(quran[index], context);
            } else {
              return _loadingIndicator();
            }
          });
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _qurans(Quran quran, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultMargin, left: 5, right: 5),
      padding: EdgeInsets.all(defaultMargin),
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: kGreyColor.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  quran.asma.toString(),
                  style: purpleTextStyle.copyWith(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quran.ayat.toString() + " ayat ",
                    style: blackTextStyle.copyWith(fontSize: 15),
                  ),
                  Text("(${quran.type.toString()})")
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(quran.nama.toString(),
                  style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(
                "(${quran.arti.toString()})",
                style: blackTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quran.keterangan.toString(),
                style: greyTextStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.justify,
                maxLines: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
