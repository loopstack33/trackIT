

import '../../../enums/dependencies.dart';

class WalletDetails extends StatelessWidget {
  const WalletDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child: TabBarView(
          children: [
            ListView.builder(itemBuilder: (context,index){
              return  TransactionCard(isPay:false,
              onTap2: (){
                Get.to(()=> const TransactionDetail());
              });
            },
            shrinkWrap: true,
            itemCount: 10,),
            ListView.builder(itemBuilder: (context,index){
              return  TransactionCard(isPay:true,onTap: (){},
                  onTap2: (){
                    Get.to(()=> const TransactionDetail(
                      isIncome: false
                    ));
                  });
            },
              shrinkWrap: true,
              itemCount: 10,),
          ],
        ));
  }
}
