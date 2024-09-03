enum StartParamType { referral, pageLink, vrLink, unknown }

abstract class StartParam {
  StartParamType get type;
  void handle();
}

class Referral extends StartParam {
  final String parrainId;

  Referral(this.parrainId);

  

  @override
  StartParamType get type => StartParamType.referral;

  @override
  void handle() {
    print('ID de parrain détecté : $parrainId');
  }
}

class PageLink extends StartParam {
  final String pageRoute;

  PageLink(this.pageRoute);

  @override
  StartParamType get type => StartParamType.pageLink;


  @override
  void handle() {
    print('Lien de page détecté : $pageRoute');
  }
}

class VRLink extends StartParam {
  final String vrLink;

  VRLink(this.vrLink);

  @override
  StartParamType get type => StartParamType.vrLink;

  @override
  void handle() {
    print('Lien VR détecté : $vrLink');
  }
}

class UnknownStartParam extends StartParam {
  @override
  StartParamType get type => StartParamType.unknown;

  @override
  void handle() {
    print('Paramètre inconnu');
  }
}
