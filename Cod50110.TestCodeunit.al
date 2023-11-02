codeunit 50110 TestCodeunit
{
    [TryFunction]
    local procedure MyTryProc()
    begin
        Error('');
        exit(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterDeleteEvent', '', false, false)]
    local procedure REDelete(var Rec: Record "Reservation Entry"; RunTrigger: Boolean)
    var
        _t: Record MyTable;
    begin
        if not MyTryProc() then begin
            _t.Init();
            _t.RENo := Rec."Entry No.";
            _t.CallStack := GetLastErrorCallStack();
            _t.Insert(true);
        end;
    end;
}

table 50107 MyTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'EntryNo';
        }
        field(2; RENo; Integer)
        {
            Caption = 'Reservation Enty No.';
        }
        field(3; CallStack; Text[2048])
        {
            Caption = 'Call Stack';
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    local procedure GetLastEntryNo(): integer
    var
        _t: Record MyTable;
    begin
        if _t.FindLast() then
            exit(_t.EntryNo)
        else
            exit(0);
    end;

    trigger OnInsert()
    begin
        if EntryNo = 0 then
            EntryNo := GetLastEntryNo() + 1;
    end;
}