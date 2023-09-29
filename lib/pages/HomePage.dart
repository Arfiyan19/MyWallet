import 'package:myWallet/constant/route_constants.dart';
import 'package:myWallet/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: Color.fromARGB(255, 189, 156, 13),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
            child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Rangkuman Bulan Ini",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .black, // Set text color to white for better visibility
                  ),
                ),
              ),
            ),
            // Text(
            //   "Rangkuman Bulan Ini",
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            // Text("Total Pengeluaran: \Rp $totalExpense"),
            // Text("Total Pemasukan: \Rp $totalIncome"),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Icon(Icons.download, color: Colors.green),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pemasukan",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 12),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "\Rp $totalIncome",
                                // $totalIncome,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Icon(Icons.upload, color: Colors.red),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pengeluaran",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 12),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "\Rp $totalExpense",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          )
                        ],
                      )
                    ]),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 168, 130, 24),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1)),
                  minX: 0,
                  maxX: 7,
                  minY: 0,
                  maxY: 1000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 200),
                        FlSpot(1, 150),
                        FlSpot(2, 450),
                        FlSpot(3, 300),
                        FlSpot(4, 600),
                        FlSpot(5, 500),
                        FlSpot(6, 800),
                        FlSpot(7, 1000),
                      ],
                      isCurved: true,
                      color: Colors.green,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 400),
                        FlSpot(1, 550),
                        FlSpot(2, 300),
                        FlSpot(3, 700),
                        FlSpot(4, 400),
                        FlSpot(5, 600),
                        FlSpot(6, 300),
                        FlSpot(7, 800),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ])),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/income.png',
                        label: "Tambah Pemasukan",
                        onTap: () {
                          Navigator.pushNamed(context, addIncomeRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/expense.png',
                        label: "Tambah Pengeluaran",
                        onTap: () {
                          Navigator.pushNamed(context, addExpenseRoute);
                        }),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/lists.png',
                        label: "Detail Cash Flow",
                        onTap: () {
                          Navigator.pushNamed(context, detailCashFlowRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/settings.png',
                        label: "Pengaturan",
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        }),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
