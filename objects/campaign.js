var allCampaigns;

function Campaign( clubName ) {
    this.name = "";
    this.club = clubName;
    this.goalAmnt = 0;
    this.currentAmnt = 0;
    this.startAmnt = 0;
    this.startdate = "";
    this.enddate = "";
    this.picture = "";
    this.description = "";
    //if (allcampaigns == undefined) {
      //  var allcampaigns = [];
    //}
    //allcampaigns.append(this);
};

Campaign.prototype.setName = function( newName ) {
	this.name = newName;
};
