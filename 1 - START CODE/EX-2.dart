class BankAccount {
  //TODO
  final int _accountId;
  final String _accountOwner;
  double _balance;

  BankAccount(this._accountId, this._accountOwner, [this._balance = 0]);

  int get accountId => _accountId;
  String get accountOwner => _accountOwner;
  double get balance => _balance;

  void credit(double amount) {
    if (amount <= 0) {
      throw Exception("Credit amount must be greater than zero!");
    }
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw Exception("Withdrawal amount must be greater than zero!");
    }
    if (_balance < amount) {
      throw Exception("Insufficient balance for withdrawal!");
    }
    _balance -= amount;
  }

  @override
  String toString() {
    return 'Account ID: $_accountId | Owner: $_accountOwner | Balance: \$${_balance.toStringAsFixed(2)}';
  }
}

class Bank {
  // TODO
  final String _bankName;
  final List<BankAccount> _accounts = [];

  Bank(this._bankName);

  String get bankName => _bankName;
  List<BankAccount> get accounts => List.unmodifiable(_accounts);

  BankAccount createAccount(int accountId, String accountOwner) {
    for (var acc in _accounts) {
      if (acc.accountId == accountId) {
        throw Exception("Account with ID $accountId already exists!");
      }
    }

    var newAccount = BankAccount(accountId, accountOwner);
    _accounts.add(newAccount);
    return newAccount;
  }

  @override
  String toString() {
    return '''
      Bank Name: $_bankName
      Number of Accounts: ${_accounts.length}
      --------------------------------------
${_accounts.map((acc) => '      ' + acc.toString()).join('\n')}
      --------------------------------------
    ''';
  }
}

void main() {
  Bank myBank = Bank("CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.toString());
  print('');

  ronanAccount.credit(100);
  print(ronanAccount.toString());
  print('');

  ronanAccount.withdraw(50);
  print(ronanAccount.toString());
  print('');

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }

  myBank.createAccount(101, 'Honlgy');
  
  print('');
  print('Bank Summary:');
  print(myBank.toString());
}
