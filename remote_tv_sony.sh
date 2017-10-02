#!/bin/bash

#Change these to your variables
SonyBraviaPreSharedKey="0000"
SonyBraviaIP="192.168.1.195"
SonyBraviaMAC="9c:ad:97:06:a3:3d"

set -e

cd $(dirname $0)

if [ "$1" = "" ]; then
  echo "Usage: $0 <COMMAND>"
  exit 1
fi

if [ "$1" = "PowerOn" ]; then
  wakeonlan $SonyBraviaMAC >/dev/null
  echo "PowerOn: ✓"
  exit 0
fi

declare -A commandmap
commandmap[PowerOff]="AAAAAQAAAAEAAAAvAw=="
commandmap[PowerOn]="AAAAAQAAAAEAAAAuAw=="
commandmap[VolumeUp]="AAAAAQAAAAEAAAASAw=="
commandmap[VolumeDown]="AAAAAQAAAAEAAAATAw=="
commandmap[Mute]="AAAAAQAAAAEAAAAUAw=="
commandmap[Input]="AAAAAQAAAAEAAAAlAw=="
commandmap[GGuide]="AAAAAQAAAAEAAAAOAw=="
commandmap[EPG]="AAAAAgAAAKQAAABbAw=="
commandmap[Favorites]="AAAAAgAAAHcAAAB2Aw=="
commandmap[Display]="AAAAAQAAAAEAAAA6Aw=="
commandmap[Home]="AAAAAQAAAAEAAABgAw=="
commandmap[Options]="AAAAAgAAAJcAAAA2Aw=="
commandmap[Return]="AAAAAgAAAJcAAAAjAw=="
commandmap[Up]="AAAAAQAAAAEAAAB0Aw=="
commandmap[Down]="AAAAAQAAAAEAAAB1Aw=="
commandmap[Right]="AAAAAQAAAAEAAAAzAw=="
commandmap[Left]="AAAAAQAAAAEAAAA0Aw=="
commandmap[Confirm]="AAAAAQAAAAEAAABlAw=="
commandmap[Red]="AAAAAgAAAJcAAAAlAw=="
commandmap[Green]="AAAAAgAAAJcAAAAmAw=="
commandmap[Yellow]="AAAAAgAAAJcAAAAnAw=="
commandmap[Blue]="AAAAAgAAAJcAAAAkAw=="
commandmap[Num1]="AAAAAQAAAAEAAAAAAw=="
commandmap[Num2]="AAAAAQAAAAEAAAABAw=="
commandmap[Num3]="AAAAAQAAAAEAAAACAw=="
commandmap[Num4]="AAAAAQAAAAEAAAADAw=="
commandmap[Num5]="AAAAAQAAAAEAAAAEAw=="
commandmap[Num6]="AAAAAQAAAAEAAAAFAw=="
commandmap[Num7]="AAAAAQAAAAEAAAAGAw=="
commandmap[Num8]="AAAAAQAAAAEAAAAHAw=="
commandmap[Num9]="AAAAAQAAAAEAAAAIAw=="
commandmap[Num0]="AAAAAQAAAAEAAAAJAw=="
commandmap[Num11]="AAAAAQAAAAEAAAAKAw=="
commandmap[Num12]="AAAAAQAAAAEAAAALAw=="
commandmap[ChannelUp]="AAAAAQAAAAEAAAAQAw=="
commandmap[ChannelDown]="AAAAAQAAAAEAAAARAw=="
commandmap[SubTitle]="AAAAAgAAAJcAAAAoAw=="
commandmap[ClosedCaption]="AAAAAgAAAKQAAAAQAw=="
commandmap[Enter]="AAAAAQAAAAEAAAALAw=="
commandmap[DOT]="AAAAAgAAAJcAAAAdAw=="
commandmap[Analog]="AAAAAgAAAHcAAAANAw=="
commandmap[Teletext]="AAAAAQAAAAEAAAA/Aw=="
commandmap[Exit]="AAAAAQAAAAEAAABjAw=="
commandmap[Analog2]="AAAAAQAAAAEAAAA4Aw=="
commandmap[*AD]="AAAAAgAAABoAAAA7Aw=="
commandmap[Digital]="AAAAAgAAAJcAAAAyAw=="
commandmap[Analog?]="AAAAAgAAAJcAAAAuAw=="
commandmap[BS]="AAAAAgAAAJcAAAAsAw=="
commandmap[CS]="AAAAAgAAAJcAAAArAw=="
commandmap[BSCS]="AAAAAgAAAJcAAAAQAw=="
commandmap[Ddata]="AAAAAgAAAJcAAAAVAw=="
commandmap[PicOff]="AAAAAQAAAAEAAAA+Aw=="
commandmap[Tv_Radio]="AAAAAgAAABoAAABXAw=="
commandmap[Theater]="AAAAAgAAAHcAAABgAw=="
commandmap[SEN]="AAAAAgAAABoAAAB9Aw=="
commandmap[InternetWidgets]="AAAAAgAAABoAAAB6Aw=="
commandmap[InternetVideo]="AAAAAgAAABoAAAB5Aw=="
commandmap[Netflix]="AAAAAgAAABoAAAB8Aw=="
commandmap[SceneSelect]="AAAAAgAAABoAAAB4Aw=="
commandmap[Mode3D]="AAAAAgAAAHcAAABNAw=="
commandmap[iManual]="AAAAAgAAABoAAAB7Aw=="
commandmap[Audio]="AAAAAQAAAAEAAAAXAw=="
commandmap[Wide]="AAAAAgAAAKQAAAA9Aw=="
commandmap[Jump]="AAAAAQAAAAEAAAA7Aw=="
commandmap[PAP]="AAAAAgAAAKQAAAB3Aw=="
commandmap[MyEPG]="AAAAAgAAAHcAAABrAw=="
commandmap[ProgramDescription]="AAAAAgAAAJcAAAAWAw=="
commandmap[WriteChapter]="AAAAAgAAAHcAAABsAw=="
commandmap[TrackID]="AAAAAgAAABoAAAB+Aw=="
commandmap[TenKey]="AAAAAgAAAJcAAAAMAw=="
commandmap[AppliCast]="AAAAAgAAABoAAABvAw=="
commandmap[acTVila]="AAAAAgAAABoAAAByAw=="
commandmap[DeleteVideo]="AAAAAgAAAHcAAAAfAw=="
commandmap[PhotoFrame]="AAAAAgAAABoAAABVAw=="
commandmap[TvPause]="AAAAAgAAABoAAABnAw=="
commandmap[KeyPad]="AAAAAgAAABoAAAB1Aw=="
commandmap[Media]="AAAAAgAAAJcAAAA4Aw=="
commandmap[SyncMenu]="AAAAAgAAABoAAABYAw=="
commandmap[Forward]="AAAAAgAAAJcAAAAcAw=="
commandmap[Play]="AAAAAgAAAJcAAAAaAw=="
commandmap[Rewind]="AAAAAgAAAJcAAAAbAw=="
commandmap[Prev]="AAAAAgAAAJcAAAA8Aw=="
commandmap[Stop]="AAAAAgAAAJcAAAAYAw=="
commandmap[Next]="AAAAAgAAAJcAAAA9Aw=="
commandmap[Rec]="AAAAAgAAAJcAAAAgAw=="
commandmap[Pause]="AAAAAgAAAJcAAAAZAw=="
commandmap[Eject]="AAAAAgAAAJcAAABIAw=="
commandmap[FlashPlus]="AAAAAgAAAJcAAAB4Aw=="
commandmap[FlashMinus]="AAAAAgAAAJcAAAB5Aw=="
commandmap[TopMenu]="AAAAAgAAABoAAABgAw=="
commandmap[PopUpMenu]="AAAAAgAAABoAAABhAw=="
commandmap[RakurakuStart]="AAAAAgAAAHcAAABqAw=="
commandmap[OneTouchTimeRec]="AAAAAgAAABoAAABkAw=="
commandmap[OneTouchView]="AAAAAgAAABoAAABlAw=="
commandmap[OneTouchRec]="AAAAAgAAABoAAABiAw=="
commandmap[OneTouchStop]="AAAAAgAAABoAAABjAw=="
commandmap[DUX]="AAAAAgAAABoAAABzAw=="
commandmap[FootballMode]="AAAAAgAAABoAAAB2Aw=="
commandmap[Social]="AAAAAgAAABoAAAB0Aw=="

IRCC=${commandmap[$1]}


if [ "$IRCC" = "" ]; then
  echo "Unknown command $1"
  exit 1
fi

code=$(curl -sw "%{http_code}" --silent -XPOST http://$SonyBraviaIP/sony/IRCC -H "X-Auth-PSK:$SonyBraviaPreSharedKey" -d "<?xml version=\"1.0\"?><s:Envelope xmlns:s=\"http://schemas
.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><s:Body><u:X_SendIRCC xmlns:u=\"urn:schemas-sony-com:service:IRCC:1\"><IRCCCode>"$IRCC"</
IRCCCode></u:X_SendIRCC></s:Body></s:Envelope>" -H 'Content-Type: text/xml; charset=UTF-8' -H 'SOAPACTION: "urn:schemas-sony-com:service:IRCC:1#X_SendIRCC"' -o /dev/null)

#Debug should return 200
#echo "Returned code = " $code

#if [ "$code" = "200" ]; then
 # echo "Command $1 transmitted"
#else
 # echo "$1: Command failed (HTTP_CODE: $code)"
 # exit 1
#fi

