#pragma semicolon 1

#include <sdktools>
#include <tf2items>
#include <tf2_stocks>

#define PLUGIN_VERSION "1.2"

public Plugin:myinfo =
{
	name = "[TF2] Taunt TFOC",
	author = "pu_shitcake",
	description = "Free taunts for all, who don't love free thing?",
	version = PLUGIN_VERSION,
	url = "http://tfoc.maxnus.com/"
};

new Handle:hPlayTaunt;

public OnPluginStart()
{
	new Handle:conf = LoadGameConfigFile("tf2.tauntem");
	
	if (conf == INVALID_HANDLE)
	{
		SetFailState("Unable to load gamedata/tf2.tauntem.txt.");
		return;
	}
	
	StartPrepSDKCall(SDKCall_Player);
	PrepSDKCall_SetFromConf(conf, SDKConf_Signature, "CTFPlayer::PlayTauntSceneFromItem");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
	hPlayTaunt = EndPrepSDKCall();
	
	if (hPlayTaunt == INVALID_HANDLE)
	{
		SetFailState("Unable to initialize call to CTFPlayer::PlayTauntSceneFromItem. Wait patiently for a fix.");
		CloseHandle(conf);
		return;
	}
	
	RegConsoleCmd("sm_taunt", Cmd_TauntMenu, "Taunt Menu");
	RegConsoleCmd("sm_taunts", Cmd_TauntMenu, "Taunt Menu");
	
	CloseHandle(conf);
	LoadTranslations("common.phrases");
	CreateConVar("tf_tauntem_version", PLUGIN_VERSION, "[TF2] Taunt 'em Version", FCVAR_NOTIFY|FCVAR_PLUGIN);
}

public Action:Cmd_TauntMenu(client, args)
{

	ShowMenu(client);
	
	return Plugin_Handled;
}

public Action:ShowMenu(client)
{
	new TFClassType:class = TF2_GetPlayerClass(client);
	new Handle:menu = CreateMenu(Tauntme_MenuSelected);
	SetMenuTitle(menu, "Taunts Menu นะ Meow");
	
	switch(class)
	{
		case TFClass_Scout:
		{
			AddMenuItem(menu, "1117", "Battin a Thousand [Scout]");
			AddMenuItem(menu, "1119", "Deep Fried Desire [Scout]");
			AddMenuItem(menu, "1168", "The Carlton [Scout]");
			AddMenuItem(menu, "1197", "The Scooty Scoot [Scout]);
			AddMenuItem(menu, "30572", "Boston Breakdance [Scout]");
			AddMenuItem(menu, "30917", "The Trackmans Touchdown [Scout]");
			AddMenuItem(menu, "30920", "The Bunnyhopper [Scout]");
			AddMenuItem(menu, "30921", "Runners Rhythm [Scout]");
			AddMenuItem(menu, "31156", "The Boston Boarder [Scout]");
			AddMenuItem(menu, "31161", "Spin-to-Win [Scout]");
			AddMenuItem(menu, "31233", "The Homerunner's Hobby [Scout]");
		}
		case TFClass_Sniper:
		{
			AddMenuItem(menu, "1116",  "I See You [Sniper]");
           		AddMenuItem(menu, "30609", "Killer Solo [Sniper]");
           		AddMenuItem(menu, "30614", "Most Wanted [Sniper]");
			AddMenuItem(menu, "30839", "Didgeridrongo [Sniper]");
			AddMenuItem(menu, "31237", "Shooter's Stakeout [Sniper]");
		}
		case TFClass_Soldier:
		{
			AddMenuItem(menu, "1113", "Fresh Brewed Victory [Soldier]");
			AddMenuItem(menu, "1196", "Panzer Pants [Soldier]");
			AddMenuItem(menu, "30673", "Soldier's Requiem [Soldier]");
			AddMenuItem(menu, "30761", "The Fubar Fanfare [Soldier]");
			AddMenuItem(menu, "31155", "Rocket Jockey [Soldier]");
			AddMenuItem(menu, "31202", "The Profane Puppeteer [Soldier]");
		}
		case TFClass_DemoMan:
		{
			AddMenuItem(menu, "1120", "Oblooterated [Demoman]");
			AddMenuItem(menu, "1114", "Spent Well Spirits [Demoman]");
			AddMenuItem(menu, "30671", "True Scotsman's Call [Demoman]");
			AddMenuItem(menu, "30840", "Scotsmann's Stagger [Demoman]");
			AddMenuItem(menu, "31153", "The Pooped Deck [Demoman]");
			AddMenuItem(menu, "31201", "The Drunken Sailor [Demoman]");
			AddMenuItem(menu, "31291", "Drunk Mann's Cannon [Demoman]");
			AddMenuItem(menu, "31292", "Shanty Shipmate [Demoman]");
		}
		case TFClass_Medic:
		{
			AddMenuItem(menu, "477", "Meet the Medic [Medic]");
			AddMenuItem(menu, "1109", "Results Are In [Medic]");
			AddMenuItem(menu, "30918", "Surgeon's Squeezebox [Medic]");
			AddMenuItem(menu, "31154", "Time Out Therapy [Medic]");
			AddMenuItem(menu, "31203", "The Mannbulance! [Medic]");
			AddMenuItem(menu, "31236", "Doctor's Defibrillators [Medic]");
		}	
		case TFClass_Pyro:
		{
			AddMenuItem(menu, "1112", "Party Trick [Pyro]");
            		AddMenuItem(menu, "30570", "Pool Party [Pyro]");
			AddMenuItem(menu, "30763", "The Balloonibouncer [Pyro]");
			AddMenuItem(menu, "30876", "The Headcase [Pyro]");
			AddMenuItem(menu, "30919", "The Skating Scorche [Pyro]");
			AddMenuItem(menu, "31157", "Scorcher's Solo [Pyro]");
			AddMenuItem(menu, "31239", "The Hot Wheeler [Pyro]");
			AddMenuItem(menu, "31322", "Roasty Toasty [Pyro]");
		}
		case TFClass_Spy:
		{
			AddMenuItem(menu, "1108", "Buy A Life [Spy]");
			AddMenuItem(menu, "30615", "The Boxtrot [Spy]");
			AddMenuItem(menu, "30762", "Disco Fever [Spy]");
			AddMenuItem(menu, "30922", "Luxury Lounge [Spy]");
			AddMenuItem(menu, "31290", "The Travel Agent [Spy]");
			AddMenuItem(menu, "31321", "Tailored Terminal [Spy]");
		}
		case TFClass_Engineer:
		{
			AddMenuItem(menu, "1115", "Rancho Relaxo [Engineer]");
			AddMenuItem(menu, "30618", "Bucking Bronco [Engineer]");
			AddMenuItem(menu, "30842", "The Dueling Banjo [Engineer]");
			AddMenuItem(menu, "30845", "The Jumping Jack [Engineer]");
			AddMenuItem(menu, "31160", "Texas Truckin [Engineer]");
			AddMenuItem(menu, "31286", "Texas Twirl 'Em [Engineer]");
		}
		case TFClass_Heavy:
		{
			AddMenuItem(menu, "1174", "The Boiling Point [Heavy]");
			AddMenuItem(menu, "1175", "The Table Tantrum [Heavy]");
			AddMenuItem(menu, "30616", "The Proletariat Showoff [Heavy]");
			AddMenuItem(menu, "30843", "The Russian Arms Race [Heavy]");
			AddMenuItem(menu, "30844", "Soviet Strongarm [Heavy]");
			AddMenuItem(menu, "31207", "Bare Knuckle Beatdown [Heavy]");
			AddMenuItem(menu, "31320", "Russian Rubdown [Heavy]");
		}
	}

	AddMenuItem(menu, "167", "High Five");
	AddMenuItem(menu, "463", "Schadenfreude");
	AddMenuItem(menu, "438", "Director's Vision");
	AddMenuItem(menu, "1015", "Shred Alert");
	AddMenuItem(menu, "1106", "Square Dance");
	AddMenuItem(menu, "1107", "Flippin' Awesome");
	AddMenuItem(menu, "1110", "Rock Paper Scissors");
	AddMenuItem(menu, "1111", "Skullcracker");
	AddMenuItem(menu, "1118", "Conga");
	AddMenuItem(menu, "1157", "Kazotsky Kick");
	AddMenuItem(menu, "1162", "Mannrobics");
	AddMenuItem(menu, "1172", "The Victory Lap");
	AddMenuItem(menu, "1182", "Yeti Punch");
	AddMenuItem(menu, "1183", "Yeti Smash");
	AddMenuItem(menu, "30621", "Burstchester");
	AddMenuItem(menu, "30672", "Zoomin' Broom");
	AddMenuItem(menu, "30816", "Second Rate Sorcery");
	AddMenuItem(menu, "31162", "The Fist Bump");
	AddMenuItem(menu, "31288", "The Scaredy-cat!");
	
	DisplayMenu(menu, client, 20);
}

public Tauntme_MenuSelected(Handle:menu, MenuAction:action, iClient, param2)
{
	if(action == MenuAction_End)
	{
		CloseHandle(menu);
	}
	
	if(action == MenuAction_Select)
	{
		decl String:info[12];
		
		GetMenuItem(menu, param2, info, sizeof(info));
		ExecuteTaunt(iClient, StringToInt(info));
	}
}

ExecuteTaunt(client, itemdef)
{
	static Handle:hItem;
	hItem = TF2Items_CreateItem(OVERRIDE_ALL|PRESERVE_ATTRIBUTES|FORCE_GENERATION);
	
	TF2Items_SetClassname(hItem, "tf_wearable_vm");
	TF2Items_SetQuality(hItem, 6);
	TF2Items_SetLevel(hItem, 1);
	TF2Items_SetNumAttributes(hItem, 0);
	TF2Items_SetItemIndex(hItem, itemdef);
	
	new ent = TF2Items_GiveNamedItem(client, hItem);
	new Address:pEconItemView = GetEntityAddress(ent) + Address:FindSendPropInfo("CTFWearable", "m_Item");
	
	SDKCall(hPlayTaunt, client, pEconItemView) ? 1 : 0;
	AcceptEntityInput(ent, "Kill");
}
