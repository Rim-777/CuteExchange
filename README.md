### CuteExchange Ruby gem 
#### Description:
The simple way to implement the money conversion in your Ruby project 
(#By the assignment of DaWanda: www.dawanda.com)

#### Dependencies:
- Ruby 2.4.2
- Good mood
- A little courage

#### installation:

#### Open your terminal and run the following command:
 ```shell
    $ gem install cute_exchange
  ```
#### Or add  the following line to your Gemfile :
   ```shell
      gem 'cute_exchange'
      #Then run:  bundle install
   ```
#### Usage:
 `````shell
      require 'cute_exchange'
      
      # Set the currency rates with respect to a base currency:
      CuteExchange.conversion_rates('EUR', {
        'USD' => 1.11,  
        'Bitcoin' => 0.0047
      })
      
      #Create a Money instance:
      fifty_eur = CuteExchange.create_money(50, 'EUR')
      bitcoin = CuteExchange.create_money(1.12345678, 'Bitcoin')
      
      fifty_eur.class # => Money 
      
      # Get amount and currency:
      fifty_eur.amount   # => 50
      fifty_eur.currency # => "EUR"
      
    
      #Inspect the instance:
      fifty_eur.inspect  # => 50.00 EUR
      bitcoin.inspect(precision: 4) # => 1.1234 Bitcoin
      
      #Convert to a different currency:
      fifty_eur.convert_to('USD') # => "55.50 USD"
      
      # Arithmetics:
       twenty_dollars =  CuteExchange.create_money(20, 'USD')
      
       fifty_eur + fifty_eur # => 100.00 EUR
       fifty_eur - twenty_dollars # => 31.98 EUR
       fifty_eur / 2 # => 25 EUR
       twenty_dollars * 2 # => 40 USD
       
       # Comparisons:
         
       twenty_dollars == CuteExchange.create_money(20, 'USD') # => true
       twenty_dollars == CuteExchange.create_money(50, 'USD') # => false
       fifty_eur.convert_to('USD') == fifty_eur # => true    
       twenty_dollars >= fifty_eur # => false
   `````

#### Future optimization:
   - Implement validation of input data
   
#### Explanation of the Approach:  
 I tried to keep things simple make the code more readable and understandable.
 For this reason I didn't use any metaprogramming or method_missing.

 
#### License
The software is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
  