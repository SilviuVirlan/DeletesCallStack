page 50111 TryPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Integer;
    Caption = 'Try Page';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Try)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    _re: Record "Reservation Entry";
                begin
                    _re.FindLast();
                    _re.Delete();
                end;
            }
        }
    }
}