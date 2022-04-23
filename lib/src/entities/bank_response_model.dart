class BankResponseModel {
  int? id;
  String? accountNumber;
  String? iban;
  String? beneficiaryName;
  int? isVisible;
  Bank? bank;

  BankResponseModel(
      {this.id,
        this.accountNumber,
        this.iban,
        this.beneficiaryName,
        this.isVisible,
        this.bank});

  BankResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['account_number'];
    iban = json['iban'];
    beneficiaryName = json['beneficiary_name'];
    isVisible = json['is_visible'];
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_number'] = this.accountNumber;
    data['iban'] = this.iban;
    data['beneficiary_name'] = this.beneficiaryName;
    data['is_visible'] = this.isVisible;
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    return data;
  }
}

class Bank {
  int? id;
  String? name;
  String? logo;

  Bank({this.id, this.name, this.logo});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
