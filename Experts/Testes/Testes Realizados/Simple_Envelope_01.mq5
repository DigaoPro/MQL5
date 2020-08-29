void OnTick()
  {
   // Create an array
   MqlRates PriceInformation[];
   
   // Short it from currente candle to oldest candle   
   ArraySetAsSeries(PriceInformation, true);
   
   // Copy price data into the array
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);
   
   // Create an array for several prices
   double UpperBandArray[];
   double LowerBandArray[];
   
   // Short the price array from the current candle downwards
   ArraySetAsSeries(UpperBandArray, true);
   ArraySetAsSeries(LowerBandArray, true);
   
   // Define envelopes
   int EnvelopesDefinition = iEnvelopes(_Symbol, _Period, 14, 0, MODE_SMA, PRICE_CLOSE, 0.100);
   
   //Copy price info into the array
   CopyBuffer(EnvelopesDefinition, 0, 0, 3, UpperBandArray);
   CopyBuffer(EnvelopesDefinition, 1, 0, 3, LowerBandArray);
   
   // Calculate EA for the current candle
   double myUpperBandValue = NormalizeDouble(UpperBandArray[0], 6);
   double myLowerBandValue = NormalizeDouble(LowerBandArray[0], 6);
   
   // Chart output of the current EA
   if(PriceInformation[1].close > myUpperBandValue) Comment("UPPER SIGNAL");
   if(PriceInformation[1].close > myLowerBandValue) Comment("LOWER SIGNAL");
   
   if((PriceInformation[1].close < myUpperBandValue) && (PriceInformation[1].close < myLowerBandValue));
   
   Comment("myUpperBandValue: ", myUpperBandValue, "\n",
           "myLowerBandValue: ", myLowerBandValue, "\n");
  }