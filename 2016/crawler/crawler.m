(* ::Package:: *)

(* ::Title:: *)
(*CVPR 2016 Crawler*)


(* ::Section:: *)
(*Non-Classification*)


(* ::Subsection:: *)
(*Clear*)


Clear["Global`*"];
$now=Now;$here=NotebookDirectory[];
$win=StringReplace[{"/","\\",":","*","?",",","<",">","|","\""}->"_"];
$url="https://www.cv-foundation.org/openaccess/";


(* ::Subsection:: *)
(*Functions*)


XmlFilter[{a_,b_,c_}]:=Block[
	{bib=Flatten@Cases[c,XMLElement["div",{"class"->"bibref"},t___]:>t,Infinity,1]},
	<|
		"Name"->$win[a[[-1,-1,-1,-1]]],
		"PDF"->StringJoin[$url,"href"/.c[[-1,2,-2]]],
		"Bib"->StringJoin[bib/.XMLElement["br",x___]->Nothing]
	|>
];


(* ::Subsection:: *)
(*Main*)


get=Import["https://www.cv-foundation.org/openaccess/CVPR2016.py",{"HTML","XMLObject"}];
ct=Flatten@Cases[get,XMLElement["div",{"id"->"content"},t___]:>t,Infinity];
data=XmlFilter/@Partition[ct[[2,3]],3];


(* ::Subsection:: *)
(*Export*)


Export[
	FileNameJoin[{ParentDirectory[$here],"data.json"}],
	<|
		"MetaInformation"-><|
			"Now"->DateString@$now,
			"Time"->First[Now-$now],
			"Count"->Length[data]
		|>,
	"Data"->data
	|>
]
Export[
	FileNameJoin[{ParentDirectory[$here],"download.txt"}],
	"PDF"/.data
]
