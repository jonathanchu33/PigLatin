import java.util.*;

public void setup() {
	String lines[] = loadStrings("words.txt");
	System.out.println("there are " + lines.length + " lines");
	for (int i = 0 ; i < lines.length; i++) {
	  System.out.println(pigLatin(lines[i]));
	}

	String lowellHymn[] = loadStrings("LowellHymn.txt");
	ArrayList <String> realLowellHymn = new ArrayList <String>();
	int lastBreak = 0;
	int [] wordsPerLine = new int[lowellHymn.length];
	int wordCount = 0;
	for (int i = 0; i < lowellHymn.length; i++)
	{
		for (int j = 0; j < lowellHymn[i].length(); j++)
		{
			if (lowellHymn[i].charAt(j)==' ')
			{
				realLowellHymn.add(lowellHymn[i].substring(lastBreak, j));
				lastBreak = j+1;
				wordCount++;
			}
			else if (lowellHymn[i].charAt(j)=='.' || lowellHymn[i].charAt(j)==',')
			{
				realLowellHymn.add(lowellHymn[i].substring(lastBreak, j+1));
				lastBreak = j+1;
				wordCount++;
			}
		}
		lastBreak = 0;
		wordsPerLine[i] = wordCount;
		wordCount = 0;
	}

	int wordNumber = 0;
	for (int i = 0; i < lowellHymn.length; i++)
	{
		if (wordsPerLine[i] == 0)
			System.out.println();
		else
		{
			for (int j = 0; j < wordsPerLine[i]-1; j++)
			{
				System.out.print(pigLatin(realLowellHymn.get(wordNumber)) + " ");
				wordNumber++;
			}
			System.out.println(pigLatin(realLowellHymn.get(wordNumber)) + " ");
			wordNumber++;
		}
	}
}
public void draw()
{
}
public int findFirstVowel(String sWord)
//precondition: sWord is a valid String of length greater than 0.
//postcondition: returns the position of the first vowel in sWord.  If there are no vowels, returns -1
{
	for (int i = 0; i < sWord.length(); i++)
	{
		if (sWord.substring(i,i+1).equalsIgnoreCase("a") || sWord.substring(i,i+1).equalsIgnoreCase("e") || sWord.substring(i,i+1).equalsIgnoreCase("i") || sWord.substring(i,i+1).equalsIgnoreCase("o") || sWord.substring(i,i+1).equalsIgnoreCase("u"))
			return i;
	}
	return -1;
}
public int findPunctuation(String sWord)
{
	if (sWord.length()==0)
		return 0;
	else if (sWord.substring(sWord.length()-1).equals(",") || sWord.substring(sWord.length()-1).equals("."))
		return 1;
	return 0;
}
public String pigLatin(String sWord)
//precondition: sWord is a valid String of nonnegative length
//postcondition: returns the pig latin equivalent of sWord
{
	if(findPunctuation(sWord)==0)
	{
		if (sWord.length()>1 && sWord.substring(0, 2).equalsIgnoreCase("qu"))
		{
			if (sWord.substring(0,1).equals(sWord.substring(0,1).toUpperCase()))
				return sWord.substring(2,3).toUpperCase() + sWord.substring(3) + "quay";
			else
				return sWord.substring(2) + "quay";
		}
		else if (sWord.length()==0)
			return sWord;
		else 
		{
			if(findFirstVowel(sWord) == -1)
				return sWord + "ay";
			else if (findFirstVowel(sWord) == 0)
				return sWord + "way";
			else
			{
				if (sWord.substring(0,1).equals(sWord.substring(0,1).toUpperCase()))
				{
					String modified = sWord.substring(findFirstVowel(sWord), findFirstVowel(sWord)+1).toUpperCase() + sWord.substring(findFirstVowel(sWord)+1);
					return modified + sWord.substring(0, findFirstVowel(sWord)).toLowerCase() + "ay";
				}
				else 
				{
					String modified = sWord.substring(findFirstVowel(sWord));
					return modified + sWord.substring(0, findFirstVowel(sWord)) + "ay";
				}
			}
		}
	}
	else 
	{
		if (sWord.length()>1 && sWord.substring(0, 2).equalsIgnoreCase("qu"))
		{
			if (sWord.substring(0,1).equals(sWord.substring(0,1).toUpperCase()))
				return sWord.substring(2,3).toUpperCase() + sWord.substring(3,sWord.length()-1) + "quay" + sWord.substring(sWord.length()-1);
			else
				return sWord.substring(2,sWord.length()-1) + "quay" + sWord.substring(sWord.length()-1);
		}
		else 
		{
			if(findFirstVowel(sWord) == -1)
				return sWord.substring(0,sWord.length()-1) + "ay" + sWord.substring(sWord.length()-1);
			else if (findFirstVowel(sWord) == 0)
				return sWord.substring(0,sWord.length()-1) + "way" + sWord.substring(sWord.length()-1);
			else
			{
				if (sWord.substring(0,1).equals(sWord.substring(0,1).toUpperCase()))
				{
					String modified = sWord.substring(findFirstVowel(sWord), findFirstVowel(sWord)+1).toUpperCase() + sWord.substring(findFirstVowel(sWord)+1,sWord.length()-1);
					return modified + sWord.substring(0, findFirstVowel(sWord)).toLowerCase() + "ay" + sWord.substring(sWord.length()-1);
				}
				else 
				{
					String modified = sWord.substring(findFirstVowel(sWord),sWord.length()-1);
					return modified + sWord.substring(0, findFirstVowel(sWord)) + "ay" + sWord.substring(sWord.length()-1);
				}
			}
		}
	}
}
