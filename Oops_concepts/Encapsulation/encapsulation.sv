// access_specifiers - Encapsulation example

class Account;
  local int balance;          // accessible only within this class
  protected int account_id;   // accessible within this class and derived classes
  string owner_name;          // public by default

  function new(int id, int bal, string name);
    account_id = id;
    balance = bal;
    owner_name = name;
  endfunction

  function int get_balance();
    return balance;   // local var accessed from within same class - OK
  endfunction

  function void deposit(int amt);
    balance = balance + amt;
  endfunction
endclass

class SavingsAccount extends Account;
  real interest_rate;

  function new(int id, int bal, string name, real rate);
    super.new(id, bal, name);
    interest_rate = rate;
  endfunction

  function void show_id();
    $display("account_id (protected, accessible in derived class) = %0d", account_id);
    // $display(balance);  // ILLEGAL - 'balance' is local to Account, not visible here
  endfunction
endclass

module access_specifiers;
  initial begin
    Account a = new(101, 5000, "Ravi");
    SavingsAccount s = new(102, 8000, "Meena", 4.5);

    $display("owner_name (public) = %s", a.owner_name);
    $display("balance via method  = %0d", a.get_balance());
    // $display(a.balance);     // ILLEGAL - local, not accessible outside class
    // $display(a.account_id);  // ILLEGAL - protected, not accessible outside class/derived

    s.show_id();

    
  end
endmodule
