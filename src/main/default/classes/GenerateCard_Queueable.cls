public with sharing class GenerateCard_Queueable implements Queueable, Database.AllowsCallouts{

    private Blob picture;
    private Account acc;

    public GenerateCard_Queueable(Blob picture, Account acc) {
        this.picture = picture;
        this.acc = acc;
    }

    public void execute(QueueableContext context) {
        // TODO call ext. system for call creation.

        update new Account (Id = acc.Id, Name = acc.Name + ' WS Called');
    }
}