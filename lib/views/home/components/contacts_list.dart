import 'package:permission_handler/permission_handler.dart';
import '../../../enums/dependencies.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  var controller = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getContactsAccessPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (inviteController) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              final focusScope = FocusScope.of(context);
              if (!focusScope.hasPrimaryFocus) {
                focusScope.unfocus();
              }
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
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
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 20)
                          ),
                          TextWidget(text: "My Contacts", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                          const SizedBox()
                        ],
                      )),
                     Expanded(child: Padding(
                       padding: const EdgeInsets.all(20),
                       child: inviteController.contactAccessPermission.value != PermissionStatus.granted
                           ? Center(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   const SizedBox(height: 20),
                                   Image.asset("assets/images/noData.png"),
                                   const SizedBox(height: 20),
                                   TextWidget(text: "Permission To Access Contacts Not Granted", size: 16, fontFamily: "medium", color: AppColors.blackColor,
                                       textAlign: TextAlign.center),
                                   const SizedBox(height: 20),
                                   CustomButton(onTap: () async {
                                     await inviteController.getContactsAccessPermission();
                                   }, text: 'Get Permission',
                                       size: 14,
                                       textColor: AppColors.primaryColor)
                                 ],
                               ),
                             )
                           : inviteController.contactFetchLoader.value && inviteController.contactList.isEmpty
                           ? Container(
                             width: context.width,
                             alignment: Alignment.center,
                             child:  CircularProgressIndicator(
                               color: AppColors.primaryColor,
                             ),
                           )
                           : ListView.separated(
                             shrinkWrap: true,
                             padding: EdgeInsets.zero,
                             itemCount:  inviteController.contactList.toSet().toList().length,
                             itemBuilder: (context, index) {

                               var data = inviteController.contactList.toSet().toList();
                               
                               final phones = data[index].phones.map((e) => e.number).join(', ');
                               return ContactCard(
                                 contactNo:phones.isNotEmpty? phones:"",
                                 contactName: data[index].displayName,
                                 onTap: () async {
                                   if(mounted){
                                     setState(() {
                                       inviteController.selectedContact.value = data[index].displayName==""? "":
                                       data[index].displayName;
                                       inviteController.name.text = inviteController.selectedContact.value;
                                     });
                                     Get.back();
                                   }
                                 },
                               );
                             },
                             separatorBuilder: (context, index) {
                               return  const SizedBox(height: 10);
                             },
                       )
                     ))

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactName,
    this.onTap,
    required this.contactNo,
  });

  final String contactName;
  final VoidCallback? onTap;
  final String contactNo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: AppColors.primaryLight,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryLight,
              child: ClipOval(
                  child: TextWidget(text: contactName.toString()==""? "N/A":contactName[0].toString(), size: 12, fontFamily: "medium", color: AppColors.blackColor)
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: contactName.toString()==""? "N/A":contactName.toString(), size: 12, fontFamily: "medium", color: AppColors.blackColor),
                    TextWidget(text: contactNo.toString()==""? "N/A": contactNo.toString(), size: 12, fontFamily: "medium", color: AppColors.blackColor)
                  ],
                )
            ),
          ],
        ),
      )
    );
  }
}
