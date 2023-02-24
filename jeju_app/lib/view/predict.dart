import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jeju_app/view/result.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:intl/intl.dart';

// Desc: 내 정보 가져오기 / 직접 입력 선택하는 Segmented Button
// Date: 2023-02-21
// youngjin
enum WhichInfo { myStore, byMyself }

class Predict extends StatefulWidget {
  const Predict({super.key});

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  // 정보 가져오기 / 직접 입력 버튼 변수
  WhichInfo choice = WhichInfo.myStore;

  // 행정동 리스트
  late List<String> dongList = [
    '건입동',
    '구좌읍',
    '남원읍',
    '노형동',
    '대륜동',
    '대정읍',
    '대천동',
    '도두동',
    '동홍동',
    '봉개동',
    '삼도이동',
    '삼도일동',
    '삼양동',
    '서홍동',
    '성산읍',
    '송산동',
    '아라동',
    '안덕면',
    '애월읍',
    '연동',
    '영천동',
    '예래동',
    '오라동',
    '외도동',
    '용담이동',
    '용담일동',
    '우도면',
    '이도이동',
    '이도일동',
    '이호동',
    '일도이동',
    '일도일동',
    '정방동',
    '조천읍',
    '중문동',
    '중앙동',
    '천지동',
    '추자면',
    '표선면',
    '한경면',
    '한림읍',
    '화북동',
    '효돈동'
  ];

  // 카테고리 리스트
  late List<String> categoryList = [
    '한식',
    '일식',
    '중식',
    '양식',
    '패스트푸드',
    '음료',
    '외국음식'
  ];
  TextEditingController dongController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // Desc: 예측 전에 내 가게 정보 가져오기 / 직접 입력하기 선택 버튼
  // 가져오기 선택 시 자동으로 가게 정보 불러와서 출력
  // 직접 입력 선택 시 dropdown 출력
  // Date: 2023-02-22
  // youngjin
  Widget _getSetInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        SegmentedButton<WhichInfo>(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
            Color.fromARGB(46, 154, 155, 151),
          )),
          segments: const <ButtonSegment<WhichInfo>>[
            ButtonSegment<WhichInfo>(
                value: WhichInfo.myStore,
                label: Text(
                  '내 정보 가져오기',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.store,
                  color: Colors.orangeAccent,
                )),
            ButtonSegment<WhichInfo>(
                value: WhichInfo.byMyself,
                label: Text(
                  '직접 입력하기',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                ),
                icon:
                    Icon(Icons.note_add_outlined, color: Colors.orangeAccent)),
          ],
          selected: <WhichInfo>{choice},
          onSelectionChanged: (Set<WhichInfo> newChoice) {
            setState(() {
              // 버튼 누를 때 마다 controller 초기화해주기
              choice = newChoice.first;
              dongController = TextEditingController();
              categoryController = TextEditingController();
            });
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          child: choice == WhichInfo.myStore ? _myInfoArea() : _dropdownArea(),
        ),
      ],
    );
  }

  // Desc: 저장된 내 매장 정보 불러오기
  // Date: 2023-02-22
  // youngjin
  Widget _myInfoArea() {
    return Container(
      height: 250,
      padding: EdgeInsets.only(left: 100, right: 100),
      child: Column(
        children: const [
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: '매장명',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: '행정동',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: '카테고리',
            ),
          ),
        ],
      ),
    );
  }

  // Desc: 새로운 정보 입력하기
  // Date: 2023-02-22
  // youngjin
  Widget _dropdownArea() {
    // 행정동 dropdown list
    final List<DropdownMenuEntry<String>> dongEntries =
        <DropdownMenuEntry<String>>[];
    for (final dong in dongList) {
      dongEntries.add(DropdownMenuEntry<String>(value: dong, label: dong));
    }

    // 업종 dropdown list
    final List<DropdownMenuEntry<String>> categoryEntries =
        <DropdownMenuEntry<String>>[];
    for (final category in categoryList) {
      categoryEntries
          .add(DropdownMenuEntry<String>(value: category, label: category));
    }
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DropdownMenu(
              menuHeight: 200,
              width: 200,
              initialSelection: dongList[0],
              controller: dongController,
              label: const Text('행정동'),
              dropdownMenuEntries: dongEntries,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: DropdownMenu(
              menuHeight: 200,
              width: 200,
              initialSelection: categoryList[0],
              controller: categoryController,
              label: const Text('카테고리'),
              dropdownMenuEntries: categoryEntries,
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  // --------------------------------------------------------

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('매장 정보 입력'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getSetInfo(),
                const SizedBox(
                  height: 20,
                ),
                if (selectedDate == null)
                  const Text(
                    '예측하실 년/월을 선택해주세요',
                    style: TextStyle(fontSize: 20),
                  )
                else
                  Text(
                    "${DateFormat().add_y().format(selectedDate!)}년 ${DateFormat().add_M().format(selectedDate!)}월",
                    style: TextStyle(fontSize: 20),
                  ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: const Text(
                    '년/월 선택',
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: () => _onPressed(),
                ),
                const SizedBox(
                  height: 80,
                ),
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Result())));
                  },
                  child: const Text('예측'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() {
    return showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month),
      lastDate: DateTime(DateTime.now().year + 2, 12),
      initialDate: selectedDate ?? DateTime.now(),
      //show only even months
      headerColor: Colors.orangeAccent[700],
      headerTextColor: Colors.white,
      selectedMonthBackgroundColor: Colors.amber[900],
      selectedMonthTextColor: Colors.white,
      unselectedMonthTextColor: Colors.black,
      confirmText: const Text(
        '선택',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      cancelText: Text('취소'),
      yearFirst: true,
      roundedCornersRadius: 20,
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
        });
      }
    });
  }
} // End ---------------------------------------



