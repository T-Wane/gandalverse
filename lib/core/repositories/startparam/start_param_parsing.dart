import 'start_param.dart';

extension StartParamParsing on String {
  
  StartParam parseStartParam() {
    if (startsWith('gogverseId')) {
      final parrainId = substring('gogverseId'.length);
      return Referral(parrainId);
    } else if (startsWith('gogverselink')) {
      final link = substring('gogverselink'.length);
      return VRLink(link);
    } else if (startsWith('gogversesc')) {
      final pageRoute = substring('gogversesc'.length);
      return PageLink(pageRoute);
    } else {
      return UnknownStartParam();
    }
  }
}
