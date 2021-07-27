type state =
  record
    goal     : nat;
    deadline : timestamp;
    backers  : map (address, nat);
    funded   : bool
  end
entrypoint contribute (storage store : state;
                   const sender  : address;
                   const amount  : mutez)
  : storage * list (operation) is
  var operations : list (operation) := []
  begin
    if now > store.deadline then
      fail "Deadline passed"
    else
      if store.backers.[sender] = None then
        store :=
          copy store with
            record
              backers = map_add store.backers (sender, amount)
            end
      else null
  end with (store, operations)
