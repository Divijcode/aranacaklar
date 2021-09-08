import 'package:aranacaklar/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTile extends StatefulWidget {
  CustomTile(
      {Key? key,
      required this.isVisible,
      required this.isFire,
      required this.phoneNo,
      required this.address,
      required this.desc,
      required this.shopName,
      required this.shopCategoryName})
      : super(key: key);
  bool? isVisible;
  final String? shopName;
  final String? shopCategoryName;
  final bool? isFire;
  final String? phoneNo;
  final String? address;
  final String? desc;

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.isVisible = widget.isVisible! ? false : true;
              });
            },
            child: ListTile(
              // visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text(
                widget.shopName!,
                style: TextStyle(
                  fontSize: textDefualtSize,
                  color: listTitleColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Graphik',
                  letterSpacing: -0.3,
                ),
              ),
              subtitle: Text(
                widget.shopCategoryName!,
                style: TextStyle(
                  fontSize: textSubtitleDefualtSize,
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Graphik',
                  letterSpacing: -0.3,
                ),
              ),
              leading: CircleAvatar(
                radius: 20,
                child: Text(
                  widget.shopName!.substring(0, 1).toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/Fire.svg',
                    height: widget.isVisible! ? 30 : 20,
                    width: widget.isVisible! ? 23 : 17,
                    color: widget.isFire! ? null : Colors.transparent,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: 25,
                    child: GestureDetector(
                        onTap: () => launch("tel:${widget.phoneNo}"),
                        child: Icon(
                          Icons.call,
                          color: Colors.green,
                          size: widget.isVisible! ? 30 : 20,
                        )),
                  ),
                ],
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: -10),
              dense: true,
              minVerticalPadding: 15,
            ),
          ),
          Visibility(
            visible: widget.isVisible! ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(left: 75.0, right: 20),
              child: Container(
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.address!,
                            style: TextStyle(
                              fontSize: textSubtitleDefualtSize,
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Graphik',
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.call_outlined,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("+90 ${widget.phoneNo}",
                              style: TextStyle(
                                fontSize: textSubtitleDefualtSize,
                                color: textColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Graphik',
                                letterSpacing: -0.3,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Description:",
                          style: TextStyle(
                            fontSize: textSubtitleDefualtSize,
                            color: listTitleColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Graphik',
                            letterSpacing: -0.3,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.desc!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: textColor,
                          fontSize: textSmallDefualtSize,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Graphik',
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.4,
            indent: 75,
            endIndent: 15,
          )
        ],
      ),
    );
  }
}
