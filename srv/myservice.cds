service MyService @(path: 'MyService') {
 //service defination
    function greetings(name:String(20)) returns String;
    function multiply(a: Integer , b:Integer) returns Integer;
}