

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../enums/dependencies.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  var autController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(AppColors.primaryLight);
    color.add(AppColors.primaryColor.withOpacity(0.15));


    final List<double> stops = <double>[];
    stops.add(0.1);
    stops.add(0.5);


    final LinearGradient gradientColors =
    LinearGradient(colors: color, stops: stops);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    image: DecorationImage(
                        image: AssetImage(AppImages.top),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover
                    ),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                ),
                padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: "Statistics", size: 20, fontFamily: "semi", color: AppColors.whiteColor),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> const Notifications());
                      },
                      child: Icon(Icons.notifications_active_rounded,color: AppColors.whiteColor)
                    )
                  ],
                )),
            Expanded(child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,

              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value).orderBy("date",descending: true).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data!.docs.isNotEmpty){

                             var filterList = snapshot.data!.docs.where((e)=> e.get("amount") > 1000)
                                 .where((e)=> e.get("type")=="Expense").toList();

                            return  SfCartesianChart(
                              tooltipBehavior: TooltipBehavior(enable:true),
                              plotAreaBorderWidth: 0,
                              title: ChartTitle(
                                alignment: ChartAlignment.near,
                                text: "Spending Graph",
                                textStyle: MyTextStyle.montserratMedium(14, Colors.black),
                              ),
                              zoomPanBehavior: ZoomPanBehavior(
                                  enablePanning: true,
                                  enableDoubleTapZooming: true,
                                  enableSelectionZooming: true,
                                  enablePinching: true,
                                  zoomMode: ZoomMode.x,
                                  maximumZoomLevel: 0.7
                              ),
                              primaryXAxis: CategoryAxis(
                                arrangeByIndex: true,
                                labelRotation: 80,
                                majorGridLines: const MajorGridLines(width: 0,),
                                labelStyle: MyTextStyle.montserratMedium(10, Colors.black),
                              ),
                              primaryYAxis:  NumericAxis(
                                  labelFormat: "Rs {value}",
                                  labelStyle: MyTextStyle.montserratRegular(11, Colors.black),
                                  isVisible: false
                              ),
                              series:<CartesianSeries>[
                                SplineAreaSeries<dynamic, String>(
                                    sortingOrder: SortingOrder.ascending,
                                    sortFieldValueMapper: (dynamic d, _) =>  DateFormat("MMM dd").format((d["date"] as Timestamp).toDate()),
                                    borderWidth: 4,
                                    borderGradient: LinearGradient(
                                        colors: <Color>[
                                          AppColors.primaryColor,
                                          AppColors.primaryColor,
                                        ],
                                        stops: const <double>[
                                          0.2,
                                          0.9,
                                        ]
                                    ),
                                    gradient: gradientColors,
                                    splineType: SplineType.cardinal,
                                    cardinalSplineTension: 0.9,
                                    dataSource: filterList,
                                    xValueMapper: (dynamic d, _) =>  DateFormat("MMM dd").format((d["date"] as Timestamp).toDate()),
                                    yValueMapper: (dynamic d, _) =>  d["amount"],
                                    markerSettings: MarkerSettings(
                                        isVisible: true,
                                        color: AppColors.primaryColor,
                                        borderColor: AppColors.whiteColor
                                    ),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      labelPosition: ChartDataLabelPosition.outside,
                                      labelAlignment: ChartDataLabelAlignment.outer,
                                      textStyle: MyTextStyle.montserratSemiBold(8, Colors.black),
                                      useSeriesColor: true,
                                     borderRadius: 10,
                                      borderColor: AppColors.primaryColor,

                                    )
                                )
                              ],
                            );
                          }
                          else {
                            return const NoData(name: "No Graph Data Found",);
                          }
                        }
                        else if(snapshot.hasError){
                          return Container();
                        }
                        else {
                          return  SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(color: AppColors.primaryColor),
                            )
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextWidget(text: "Top Spending", size: 14, fontFamily: "semi", color: AppColors.blackColor),
                    Expanded(child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value)
                          .orderBy("date",descending: true).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data!.docs.isNotEmpty){
                            var filterList = snapshot.data!.docs.where((e)=> e.get("amount") > 1000)
                                .where((e)=> e.get("type")=="Expense").toList();
                            return AnimationLimiter(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 10),
                                shrinkWrap: true,
                                itemCount: filterList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = filterList[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child:  TransactionCard(
                                            onTap2: (){
                                              Get.to(()=> TransactionDetail(
                                                  isIncome: data.get("isBill")? false : true,
                                                  data: data
                                              ));
                                            },
                                            data: data
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          else {
                            return const NoData(name: "No Transactions Yet");
                          }

                        }
                        else if(snapshot.hasError){
                          return Container();
                        }
                        else {
                          return  Shimmer(
                              linearGradient: AppColors.shimmerGradient,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return const ShimmerLoading(
                                        isLoading: true,
                                        child: DummyCard());
                                  }));
                        }
                      },
                    )),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
