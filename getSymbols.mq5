//+------------------------------------------------------------------+
//|                                                GetAllTickerbols.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//  Alireza December 2021
//  This script export list of all tickers avialable for selected broker to a csv file with shortable attribute
//+------------------------------------------------------------------+
string Ticker, PatternLine;
string csvfile = "Symbols.csv";

void OnStart()
  {
// Open output csv file
   if (FileIsExist(csvfile))
   {
      FileDelete(csvfile);
   };
   int filepointer  = FileOpen( csvfile , FILE_READ|FILE_WRITE|FILE_TXT|FILE_UNICODE);
//Number of all avialable Ticker including Options, Stock, Bonds, Forex, OTC, Commodity and etc   
   int nTickerAll = SymbolsTotal(false);

// wirte headers
   PatternLine = "Ticker\tPath\tShortable\n";
   FileSeek(filepointer , 0, SEEK_END);
   FileWriteString(filepointer, PatternLine, StringLen(SYMBOL_PATH) );
 
   printf("total number of tickers is " + IntegerToString(nTickerAll));
   printf("==================================================================");
   
//Main Loop   
   while ( --nTickerAll>=0 && !IsStopped() )
    { 
      ResetLastError(); 
      Ticker = SymbolName(nTickerAll,false);
      printf(Ticker + " , " +   SymbolInfoString(Ticker , SYMBOL_PATH) + " , " + SymbolInfoInteger(Ticker , SYMBOL_TRADE_MODE)  );
      
      PatternLine = StringFormat(
         "%s\t%s\t%d\n",
         Ticker, SymbolInfoString(Ticker , SYMBOL_PATH), SymbolInfoInteger(Ticker , SYMBOL_TRADE_MODE) 
      );
      FileWriteString(filepointer, PatternLine, StringLen(PatternLine) );
      Comment("# ",nTickerAll," ",Ticker,"  DONE");
   }
   FileClose(filepointer);
 
  }

//+------------------------------------------------------------------+
