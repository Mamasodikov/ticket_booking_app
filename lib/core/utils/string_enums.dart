const String noInternetConnection = "No internet connection!";
const String operationError = "Error on operation!";
const String downloadError = "Error on downloading!";
const String serverError = "Server error!";
const String passwordNotMatch = "Password do not match!";
const String noSuchUser = "No such user!";
const String incorrectData = "Incorrect Data!";
const String checkInternet = "Check your internet!";
const String confirmation = "Do you confirm?";
const String YES = "Yes";
const String NO = "No";
const String scannerToContinue =
    "Place your finger to the scanner to continue!";
const String OPEN = "Open";
const String placeholderAvatar = "https://media.wired.co.uk/photos/606dbb7e307b8f0b37c73705/master/w_1600%2Cc_limit/musktwitter.jpg";
const String placeholderImage1 = "https://via.placeholder.com/500";
const String placeholderImage2 = "https://www.smartprix.com/bytes/wp-content/uploads/2021/05/Google_IO_2021_Collection_Share_Card3.max-1400x1400-1.jpg";

enum Currency { USD, UZS, RUB }

extension CurrencyExtension on Currency {
  String get value {
    switch (this) {
      case Currency.USD:
        return 'USD';
      case Currency.UZS:
        return 'UZS';
      case Currency.RUB:
        return 'RUB';
      default:
        return 'UNK';
    }
  }
}

enum Topics { INFO, SCIENCE, BIO, BUSS, MARK }

extension TopicsExtension on Topics {
  String get value {
    switch (this) {
      case Topics.INFO:
        return 'Information Technologies';
      case Topics.SCIENCE:
        return 'Science';
      case Topics.BIO:
        return 'Biology';
      case Topics.BUSS:
        return 'Bussiness';
      case Topics.MARK:
        return 'Marketing';
      default:
        return 'Unknown';
    }
  }
}

class CurrencyModel {
  const CurrencyModel(this.name, this.code);

  final String code;
  final String name;

  @override
  String toString() => name;
}

const List<CurrencyModel> currencies = <CurrencyModel>[
  CurrencyModel('USD', 'USD'),
  CurrencyModel('UZS', 'UZS'),
  CurrencyModel('RUB', 'RUB'),
];

class TopicModel {
  const TopicModel(this.name, this.code);

  final String code;
  final String name;

  @override
  String toString() => name;
}

const List<TopicModel> topics = <TopicModel>[
  TopicModel('Information Technologies', 'Information Technologies'),
  TopicModel('Science', 'Science'),
  TopicModel('Biology', 'Biology'),
  TopicModel('Business', 'Business'),
];
