public with sharing class GenerateQrCode_Queueable implements Queueable, Database.AllowsCallouts {
    private Integer pictureSize;
    private Account acc;

    public GenerateQrCode_Queueable(Integer pictureSize, Account acc) {
        this.pictureSize = pictureSize;
        this.acc = acc;
    }

    
    public void execute(QueueableContext context) {
        String data = acc.Id;
        String pictureSize = pictureSize + 'x' + pictureSize;
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:QRCodeGen/v1/create-qr-code/?size=' + pictureSize +'&data=' + data);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Blob picture = res.getBodyAsBlob();
        GenerateCard_Queueable generateCardInstance = new GenerateCard_Queueable(picture, acc);
        System.enqueueJob(generateCardInstance);
    }
}