function Campaign( clubName ) {
    this.name = "";
    this.club = clubName;
    this.goalAmnt = 0;
    this.currentAmnt = 0;
    this.startAmnt = 0;
    this.startdate = 0;
    this.enddate = 0;
    this.picture = "";
    this.description = "";
};

Campaign.prototype.setName = function( newName ) {
	this.name = newName;
};
