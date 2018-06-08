(* ::Package:: *)

(* ::Title:: *)
(*ICCV 2017 Crawler*)


(* ::Section:: *)
(*Non-Classification*)


(* ::Subsection:: *)
(*Clear*)


Clear["Global`*"];
$now=Now;
$here=DirectoryName[$InputFileName /. "" :> NotebookFileName[]];
$win=StringReplace[{"/","\\",":","*","?",",","<",">","|","\""}->"_"];
$url="http://openaccess.thecvf.com/";


(* ::Subsection:: *)
(*Functions*)


XmlFilter[{a_,b_,c_}]:=Block[
	{
		name=FirstCase[a,XMLElement["a",{__},{dl_}]:>dl,Missing,Infinity],
		pdf=FirstCase[c,XMLElement["a",{"shape"->"rect","href"->h_},{"pdf"}]:>h,Missing,Infinity],
		bib=FirstCase[c,XMLElement["div",{"class"->"bibref"},t___]:>t,Missing,Infinity],
		arxiv=FirstCase[c,XMLElement["a",{"shape"->"rect","href"->h_},{"arXiv"}]:>h,Missing,Infinity],
		video=FirstCase[c,XMLElement["a",{"shape"->"rect","href"->h_},{"video"}]:>h,Missing,Infinity]
	},
	Association@@{
		"Name"->$win[name],
		"PDF"->StringJoin[$url,pdf],
		"Bib"->StringJoin[bib/.XMLElement["br",x___]->Nothing],
		If[arxiv===Missing,Nothing,"ArXiv"->arxiv],
		If[video===Missing,Nothing,"Video"->video]
	}
];


(* ::Subsection:: *)
(*Main*)


get=Import["http://openaccess.thecvf.com/ICCV2017.py",{"HTML","XMLObject"}];
ct=Flatten@Cases[get,XMLElement["div",{"id"->"content"},t___]:>t,Infinity];
data=XmlFilter/@Partition[Flatten@Cases[ct,XMLElement["dl",{},dl_]:>dl],3];


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
