(* ::Package:: *)

(* ::Title:: *)
(*CVPR 2018 Crawler*)


(* ::Section:: *)
(*Non-Classification*)


(* ::Subsection:: *)
(*Clear*)


Clear["Global`*"]
$now=Now;$here=NotebookDirectory[];
$win=StringReplace[{"/","\\",":","*","?",",","<",">","|","\""}->"_"];
arXiv=ServiceConnect["ArXiv"]


(* ::Subsection:: *)
(*Functions*)


ArXivSearch[q_]:=Block[
	{articles=arXiv["Search",{"Query"->q}]//Normal,post},
	post=First@TakeSmallestBy[articles,EditDistance[#["Title"],q]&,1];
	<|
		"Name"->$win[post["Title"]],
		"ArXiv"->First@StringSplit[post["ID"],"v"],
		"PDF"->StringJoin["https://arxiv.org/pdf/",post["ID"],".pdf"]
	|>
];
SearchList[list_]:=With[
	{name=FileNameJoin[{$here,"temp",ToString[Hash@list]<>".json"}]},
	If[FileExistsQ@name,Return[],Export[name,ArXivSearch/@list]]
];


(* ::Subsection:: *)
(*Main*)


get=Import[
	"https://raw.githubusercontent.com/amusi/daily-paper-computer-vision/master/2018/cvpr2018-paper-list.csv",
	{"CSV","Dataset"},"HeaderLines"->1
]//Normal;
Quiet[CreateDirectory@FileNameJoin[{$here,"temp"}]];
Quiet[SearchList/@Partition[("Title"/.get),UpTo[1]]];
files=FileNames["*",FileNameJoin[{$here,"temp"}]];
data=Flatten[Import[#,"RawJSON"]&/@files//Quiet]//DeleteDuplicates


(* ::Subsection:: *)
(*Export*)


Export[
	FileNameJoin[{ParentDirectory[$here],"data.json"}],
	<|
		"MetaInformation"-><|
			"Now"->DateString@$now,
			"Time"->QuantityMagnitude@UnitConvert[Now-$now,"SI"],
			"Count"->Length[data]
		|>,
	"Data"->DeleteCases[data,$Failed]
	|>
]
Export[
	FileNameJoin[{ParentDirectory[$here],"download.txt"}],
	DeleteCases[#["PDF"]&/@data,$Failed[x___]]
]
