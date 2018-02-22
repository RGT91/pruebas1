package testmaven;
%%
%class Aléxico
%public
%standalone
%unicode
COMMENT = ("--"[^\n\r\"]+) | ("{-\n" [^]* "-}")
ID_Reserved   = {CaseId} | {ClassId} | {DataId} | {DefaultId} | {DerivingId} | {DoId} | {ElseId} | {IfId} | {ImportId} | {InId} | {InfixId} | {InfixlId} | {InfixrId} | {InstanceId} | {LetId} | {ModuleId} | {NewtypeId} | {OfId} | {ThenId} | {TypeId} | {WhereId} | {WildcardId}
CaseId        = "case"
ClassId       = "class"
DataId        = "data"
DefaultId     = "default"
DerivingId    = "deriving"
DoId          = "do"
ElseId        = "else"
IfId          = "if"
ImportId      = "import"
InId          = "in"
InfixId       = "infix"
InfixlId      = "infixl"
InfixrId      = "infixr"
InstanceId    = "instance"
LetId         = "let"
ModuleId      = "module"
NewtypeId     = "newtype"
OfId          = "of"
ThenId        = "then"
TypeId        = "type"
WhereId       = "where"
WildcardId    = "_"
PUNTO   = \.
ENTERO  = [1-9][0-9]* | 0+
ID_JAVA = [:jletter:] [:jletterdigit:]*
%%
{ENTERO}      { System.out.print("ENTERO("+yytext() + ")"); }
{ID_Reserved}     { System.out.print("ID_Reserved("+yytext() + ")"); }
{ID_JAVA}     { System.out.print("ID_JAVA("+yytext() + ")"); }
{COMMENT}     { System.out.print("COMMENT("+yytext() + ")"); }
.             { }
