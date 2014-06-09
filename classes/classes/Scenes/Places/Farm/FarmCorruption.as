package classes.Scenes.Places.Farm
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.ConsumableLib;
	import classes.Items.Consumables.SimpleConsumable;
	import classes.ItemSlotClass;
	import classes.Scenes.Dungeons.DeepCave.EncapsulationPod;
	import classes.StatusAffects;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class FarmCorruption extends AbstractFarmContent
	{
		
		public function whitneySprite():void
		{
			farm.whitneySprite();
		}
		
		public function FarmCorruption() 
		{
			
		}
		
		protected function corruptFollowers():int
		{
			var count:int = 0;
			
			if (kGAMECLASS.jojoScene.campCorruptJojo()) count++;
			if (kGAMECLASS.amilyScene.amilyCorrupt()) count++;
			if (kGAMECLASS.izmaScene.izmaFollower()) count++;
			if (kGAMECLASS.sophieBimbo.bimboSophie()) count++;
			if (kGAMECLASS.vapula.vapulaSlave()) count++;
			if (kGAMECLASS.ceraphScene.ceraphIsFollower()) count++;
			if (kGAMECLASS.latexGirl.latexGooFollower()) count++;
			
			return count;
		}

		public function whitneyCorruption(mod:int = 0):int
		{
			if (mod != 0)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] += mod;
				
				// Track highest corruption value
				if (flags[kFLAGS.WHITNEY_CORRUPTION] > flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST]) flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST] = flags[kFLAGS.WHITNEY_CORRUPTION];
			}
			
			// Cap the values into the appropriate range
			if (flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 30 ) flags[kFLAGS.WHITNEY_CORRUPTION] = 30;
			else if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 60) flags[kFLAGS.WHITNEY_CORRUPTION] = 60;
			else if (flags[kFLAGS.WHITNEY_LEAVE_61_90] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 90) flags[kFLAGS.WHITNEY_CORRUPTION] = 90;
			else if (flags[kFLAGS.WHITNEY_MENU_91_119] == 0 && flags[kFLAGS.WHITNEY_CORRUPTION] > 119) flags[kFLAGS.WHITNEY_CORRUPTION] = 119;

			// Clamp values to valid min/max
			if (flags[kFLAGS.WHITNEY_CORRUPTION] < 0) flags[kFLAGS.WHITNEY_CORRUPTION] = 0;
			if (flags[kFLAGS.WHITNEY_CORRUPTION] >= 120)
			{
				flags[kFLAGS.WHITNEY_CORRUPTION] = 120;
			}

			return flags[kFLAGS.WHITNEY_CORRUPTION];
		}

		public function whitneyCorrupt():Boolean
		{
			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] > 0) return true;
			return false;
		}

		public function whitneyDom():Boolean
		{
			if (flags[kFLAGS.WHITNEY_DOM] == 1) return true;
			return false;
		}

		public function whitneyDefurred():Boolean
		{
			if (flags[kFLAGS.WHITNEY_DEFURRED] == 1) return true;
			return false;
		}

		public function whitneyHasTattoo():Boolean
		{
			if (flags[kFLAGS.WHITNEY_TATTOO_COLLAR] != 0) return true;
			if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) return true;
			if (flags[kFLAGS.WHITNEY_TATOO_LOWERBACK] != 0) return true;
			if (flags[kFLAGS.WHINTEY_TATOO_BUTT] != 0) return true;
			return false;
		}

		public function whitneyOralTrain(mod:int = 0):int
		{
			if (mod == 0) return flags[kFLAGS.WHITNEY_ORAL_TRAINING];

			flags[kFLAGS.WHITNEY_ORAL_TRAINING] += mod;

			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] > 100) flags[kFLAGS.WHITNEY_ORAL_TRAINING] = 100;
			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] < 0) flags[kFLAGS.WHITNEY_ORAL_TRAINING] = 0;

			return flags[kFLAGS.WHITNEY_ORAL_TRAINING];
		}

		public function whitneyMaxedOralTraining():Boolean
		{
			if (flags[kFLAGS.WHITNEY_ORAL_TRAINING] == 100) return true;
			return false;
		}

		// Called once per day, check all the followers that have been set to the farm and change whitneys corruption as appropriate
		// Also going to use this to handle Gem value updates and shit.
		public function updateFarmCorruption():int
		{
			// Early exit if we've not actually started the corruption process
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] <= 0) return;
			
			// If Whitney was disabled the previous day, set the flag for a follow up
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 1)
			{
				flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 2;
			}

			// Process queued farm upgrades

			// Breastmilkers
			if (flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] != 0 && player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") < 0)
			{
				flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] = 0;
				player.createKeyItem("Breast Milker - Installed At Whitney's Farm", 0, 0, 0, 0);
			}

			// Cockmilkers
			if (flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] != 0 && player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0)
			{
				flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] = 0;
				player.createKeyItem("Cock Milker - Installed At Whitney's Farm", 0, 0, 0, 0);
			}

			// Contraceptives
			if (flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] > 7)
				{
					flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] = 1;
					flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] = 0;
				}
			}

			// Refinery
			if (flags[kFLAGS.QUEUE_REFINERY_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_REFINERY_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_REFINERY_UPGRADE] > 3)
				{
					flags[kFLAGS.FARM_UPGRADES_REFINERY] = 1;
					flags[kFLAGS.QUEUE_REFINERY_UPGRADE] = 0
				}
			}

			// Milktank
			if (flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_MILKTANK_UPGRADE]++;

				if (flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] > 3)
				{
					flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] = 0;
					flags[kFLAGS.FARM_UPGRADES_MILKTANK] = 1;

					flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] = 1;
					flags[kFLAGS.MILK_SIZE] = 0;
				}
			}

			// Branding
			if (flags[kFLAGS.QUEUE_BRANDING_UPGRADE] != 0)
			{
				flags[kFLAGS.QUEUE_BRANDING_UPGRADE]++

				if (flags[kFLAGS.QUEUE_BRANDING_UPGRADE] > 2)
				{
					flags[kFLAGS.QUEUE_BRANDING_UPGRADE] = 0;
					flags[kFLAGS.FARM_CORRUPTION_BRANDING_MENU_UNLOCKED] = 1;
					flags[kFLAGS.QUEUE_BRANDING_AVAILABLE_TALK] = 1;
				}
			}

			// Figure out how much corruption we're going to slap on to Whitney
			var modValue:int = -1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) modValue += 1;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) modValue += 1;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 2) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) modValue += 2;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) modValue += 0.5;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] <= 20)
			{
				flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI]++;
				modValue += 2;
			}
			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1) modValue += 1;

			whitneyCorruption(modValue);

			// Now figure out how many gems we're gonna get for the day
			flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] += farmValue();

			// If Amily is producing, stack up some milks to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_AMILY] == 1 && flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1)
			{
				if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY_GIBS_MILK] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_AMILY_GIBS_MILK] = 1;
				flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
			}
			
			// If jojo is producing, stack up some drafts to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_JOJO] == 1 && flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1)
			{
				if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT] = 1;
				flags[kFLAGS.FARM_INCUDRAFT_STORED]++;
			}
			
			// If Sophie is producing, count up time since last egg and gib a new one when ready
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] > 0 && flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE] == 1)
			{
				if (flags[kFLAGS.FARM_EGG_COUNTDOWN] == 0)
				{
					flags[kFLAGS.FARM_EGG_STORED] = 1;
				}
				else
				{
					flags[kFLAGS.FARM_EGG_COUNTDOWN]--;
				}
			}
			
			// If Vapula is producing, stack up some milks to gib
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1 && flags[kFLAGS.FOLLOWER_PRODUCTION_VAPULA] == 1)
			{
				flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) flags[kFLAGS.FARM_SUCCUMILK_STORED]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA_GIBS_MILK] == 0) flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA_GIBS_MILK] == 1;
			}
			
			// If Latexy is at the farm, further modify her status values
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)
			{
				kGAMECLASS.latexGirl.gooHappiness( -0.5);
				kGAMECLASS.latexGirl.gooObedience(  0.5);
			}
			
			// If Ceraph is doing her thing
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0)
			{
				flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 7) flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] = -1;
			}
			
			// If Holli is doing her thing
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0)
			{
				flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI]++;
				
				if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 20) flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] = -1;
				
				modValue += 10;
				whitneyCorruption(2);
			}
			
			// Contraceptives
			if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 1)
			{
				if (flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] == 0) flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] = 1;
			}
			
			// Increment days since last paid out
			flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] += 1;
			
			return modValue;
		}
		
		public function collectTheGoodies():void
		{
			clearOutput();
			
			// Get gems
			if (flags[kFLAGS.FARM_CORRUPTION_DAYS_SINCE_LAST_PAYOUT] >= 7)
			{
				outputText("You stroll over to the big rock at the edge of the pepper patch, smiling as you see a small burlap sack shoved underneath a fold in the stone. You scoop it up, open it and count out " + flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] + " gems.");
				
				if (farmValue < 25) outputText(" You frown; it seems like a feeble amount for such a large operation. Perhaps you could talk to Whitney about that.");
				
				player.gems += flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING];
				flags[kFLAGS.FARM_CORRUPTION_GEMS_WAITING] = 0;
			}
			
			outputText("\n");
			
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0 || flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0 || flags[kFLAGS.FARM_EGG_STORED] > 0)
			{
				outputText("\nYour ‘farmers’ have been busy under the watchful eye of their assigned task mistress. A small bundle of goods have been stashed with the gems just awaiting your arrival.\n\n");
			}
						
			if (flags[kFLAGS.FARM_SUCCUMILK_STORED] > 0) offerItems(kFLAGS.FARM_SUCCUMILK_STORED);
			if (flags[kFLAGS.FARM_INCUDRAFT_STORED] > 0) offerItems(kFLAGS.FARM_INCUDRAFT_STORED);
			if (flags[kFLAGS.FARM_EGG_STORED] > 0) offerItems(kFLAGS.FARM_EGG_STORED);
			if (flags[kFLAGS.FARM_CONTRACEPTIVE_STORED] > 0) offerItems(kFLAGS.FARM_CONTRACEPTIVE_STORED);
			
			addButton(9, "Back", rootScene);
		}
		
		private function getItemObj(flag:int):SimpleConsumable
		{
			if (flag == kFLAGS.FARM_SUCCUMILK_STORED) return consumables.SUCMILK;
			if (flag == kFLAGS.FARM_INCUDRAFT_STORED) return consumables.INCUBID;
			if (flag == kFLAGS.FARM_EGG_STORED) return kGAMECLASS.sophieBimbo.eggTypes[kGAMECLASS.sophieBimbo.eggColors.indexOf(flags[kFLAGS.FOLLOWER_PRODUCTION_SOPHIE_COLOURCHOICE])];
			if (flag == kFLAGS.FARM_CONTRACEPTIVE_STORED) return consumables.HRBCNT;
		}
		
		private function offerItems(flag:int):void
		{
			outputText("<b>");
			
			if (flags[flag] > 1) outputText(flags[flag] + "x ");
			else outputText("A ");
			outputText(getItemObj(flag).longName);
			
			outputText("</b>");
			outputText("\n");
		}
		
		private function takeItems(flag:int):void
		{
			var item:SimpleConsumable = getItemObj(flag);
			
			if (flag == kFLAGS.FARM_EGG_STORED)
			{
				flags[kFLAGS.FARM_EGG_COUNTDOWN] = 7;
			}
			
			kGAMECLASS.menuLoc = 30;
			inventory.takeItem(item);
			flags[flag]--;
			
			doNext(collectTheGoodies);
		}

		public function farmProtection():int
		{
			var protection:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) protection += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				protection += 2;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2)
			{
				protection += 1;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1)
			{
				protection += 4;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2)
			{
				protection += 5;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1)
			{
				protection += 3;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 2)
			{
				protection += 2;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) protection += 2;

			// if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1)
			{
				protection += 1;
			}
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 2)
			{
				protection += 2;
			}

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) protection += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				protection += 1;
			}
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0) protection += 7;

			return protection;
		}

		public function farmValue():int
		{
			var fValue:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) fValue += 3;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) fValue += 3
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) fValue += 4;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) fValue += 3;
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 2) fValue += 4;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_KELLY] == 1) fValue += 1;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) fValue += 2;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) fValue += 3;
			else if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 2) fValue += 7;

			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 1) fValue *= 1.25;
			return fValue;
		}
		
		public function takeoverPrompt():Boolean
		{
			if (flags[kFLAGS.FARM_CORRUPTION_DISABLED] == 1) return false;
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) return false; // Hook the corrupt menu here
			
			if (player.cor >= 70 && corruptFollowers() >= 2 && player.level >= 12)
			{
				if (flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] == 0)
				{	
					clearOutput();
					if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4)
					{
						takeoverPromptKelly();
					}
					else if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
					{
						takeoverPromptMarbleRape();
					}
					else
					{
						takeoverPromptGeneric();
					}
					
					takeoverPromptMerge(true);
					
					return true;
				}
				else if (flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] == 2)
				{
					clearOutput();
					takeoverPromptMerge();
					return true;
				}
				else
				{
					flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY]++;
					return false;
				}
			}
			
			return false;
		}
		
		protected function takeoverPromptKelly():void
		{
			outputText("You stand at the top of a small rise overlooking the farm. From here you can just about pick out a beige-furred figure in the pepper field, hard at work. You shake your head almost in disbelief at the pastoral tableau. You remember when you found the farm when you were taking your first faltering steps in this land, with barely anything but the clothes you stood up in. You remember the relief you felt when you found this place, a pocket of peace in this disturbed land, how grateful you were to its owner to grub in the dirt with her and work for a pittance.");
			
			outputText("\n\nNow you feel nothing but contempt. How <b>dare</b> that bitch kick you off her land as if you were some common vagrant, simply because you took your rightful revenge on the centaur cunt she allowed to hang around and do as he pleased? Would she have stepped in if he had done to you what you have done to him? You think not, no, not Whitney, she’d have quite happily sat on the hill and read her book whilst her pet asshole raped the hell out of you.");
			
			outputText("\n\nOnce it affects her, well skies above, we can’t be doing with that can we? Does she have any idea how lucky she is? Who she is dealing with? How easy it would be to do to her as you have done to Kelt");
			if (kGAMECLASS.amilyScene.amilyCorrupt() || kGAMECLASS.jojoScene.campCorruptJojo())
			{
				outputText(" and the rodent slut");
				if (kGAMECLASS.amilyScene.amilyCorrupt() && kGAMECLASS.jojoScene.campCorruptJojo())
				{
					outputText("s");
				}
				outputText(" before him");
			}
			outputText("?");
		}
		
		protected function takeoverPromptMarbleRape():void
		{
			outputText("You stand at the top of a small rise overlooking the farm. From here you can just about pick out a beige-furred figure in the pepper field, hard at work. You shake your head almost in disbelief at the pastoral tableau. You remember when you found the farm when you were taking your first faltering steps in this land, with barely anything but the clothes you stood up in. You remember the relief you felt when you found this place, a pocket of peace in this disturbed land, how grateful you were to its owner to grub in the dirt with her and work for a pittance.");
			
			outputText("\n\nNow you feel nothing but contempt. How <b>dare</b> that bitch kick you off her land, as if you were some common vagrant, simply because you took what was rightfully yours from the cow bitch. Would Whitney have stepped in if Marble had done to you what you did to her? You think not, no, not Whitney, she’d have quite happily sat on the hill and read her book whilst the cow bitch did what she felt like to you, probably forcing her damn milk down your throat. But once it affects her, well skies above, we can’t be doing with that can we?");
			
			outputText("\n\nDoes she have any idea how lucky she is? Who she is dealing with? How easy it would be to break her will and make her your willing slave");
			if (kGAMECLASS.amilyScene.amilyCorrupt() || kGAMECLASS.jojoScene.campCorruptJojo())
			{
				outputText(" and the rodent slut");
				if (kGAMECLASS.amilyScene.amilyCorrupt() && kGAMECLASS.jojoScene.campCorruptJojo())
				{
					outputText("s");
				}
				outputText(" before her");
			}
			outputText("?");
		}
		
		protected function takeoverPromptGeneric():void
		{
			outputText("You stand at the top of a small rise overlooking the farm. From here you can just about pick out a beige-furred figure in the pepper field, hard at work. You shake your head almost in disbelief at the pastoral tableau. You remember when you found the farm when you were taking your first faltering steps in this land, with barely anything but the clothes you stood up in.");
			
			outputText("\n\nYou remember the relief you felt when you found this place, a pocket of peace in this disturbed land, how grateful you were to its owner to grub in the dirt with her and work for a pittance.");
			
			outputText("\n\nNow you feel nothing but contempt. Who chooses to live their life out here in staid idleness? What kind of sexless nothing nods her head at passing champions and then goes back to her book, not giving a flying fuck about anyone or anything as long as it doesn’t directly affect them? Does she have any idea how lucky she is, how merciful you are that you let her live her useless life in peace, with you just over the hill with a pile of sex slaves gathering? What you would give, what you would do to make her eyes open wide in dismay, to make her see a [man] she ignored passing through her yard with bigger ideas, coming back to completely destroy her.");
		}
		
		protected function takeoverPromptMerge(firstTime:Boolean = false):void
		{
			flags[kFLAGS.FARM_CORRUPT_PROMPT_DISPLAY] = 1;
			
			if (firstTime)
			{
				outputText("\n\nYou let your anger grow and then rage like a wildfire through you, coursing through your veins; increasingly these days, you are finding that your passion allows you to think clearer, to better fuel your muse. There’s potential in this farm, you can see that, you could turn it to your own purposes, but of course, the narrow minded bitch in the field below will never realise it herself. You will have to go down and put her in her place first. The only question is, now or later?");
			}
			else
			{
				// (plays every two times PC visits the farm for as long as they meet requirements) 
				outputText("Again, you find yourself standing on the bluff overlooking the farm, and you feel yourself filled with unholy rage at the woman below who stands against you and your plans for this piece of property. Do you put your plan into motion now or later?");
			}
			
			menu();
			addButton(0, "Now", takeoverPromptNow);
			addButton(1, "Later", takeoverPromptLater);
			addButton(2, "Never", takeoverPromptNever);
		}
		
		protected function takeoverPromptNow():void
		{
			clearOutput();
			
			outputText("You stride down to the farm and leap over a gate. You move casually, swaggering towards the pepper field with no obvious intent. When Whitney spots you and slowly stands up from her weeding, you raise your hand in friendly greeting, and to demonstrate your peacefulness, you theatrically hold up your [weapon] and then discard it with a careless swing of your arm.");

			// if PC has Kelly or PC raped Marble
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 || player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\nShe doesn’t move or shoo you away, but you can see a great deal of tenseness in her face. “<i>I already told you, I don’t want you on my farm,</i>” she says when you are face to face, her voice low and angry. You shoot your hands up and look around you in mocking exasperation, appealing to an audience that isn’t there.");
			}
			else
			{
				outputText("\n\nShe looks at you with tense uncertainty. “<i>Listen [name], I’m glad you’re here. I’ve been meaning to talk to you. I... I don’t think I want you coming to the farm no more. You’ve changed since I first got to know you, you... smell different these days. Like a demon, if you want the truth. I let it go because I know you and I’ve always said you gotta tend to your own knittin', but...</i>” She trails off as you stick out your lower lip in mocking hurt.");
			}

			outputText("\n\n“<i>All I want to do is talk. I’ve got some big plans for your farm, and I want to discuss them with you.</i>”");

			outputText("\n\n“<i>There is nothing to discuss.</i>” she replies.");

			outputText("\n\n“<i>Oh, but I think there is.</i>” You take a step towards Whitney, and immediately she steps back, gropes into her wheelbarrow, brings out a cocked crossbow, and points it at you. You grin.");

			// if PC has Kelly
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4)
			{
				outputText("\n\n“<i>Cute. But, you know, Kelt had a bow. He practiced with it every day. To protect your farm, I believe.</i>” You pause and look her dead in the eye. “<i>Get a good look at Kelt recently? Would you like that to happen to you? To be on your knees, begging me to cum on your face? Because the way I see it, there isn’t much protecting your farm these days. Just about anyone could walk in here and do as they please. As you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}
			// else if PC raped Marble
			else if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\n“<i>Cute. But, you know, Marble had a hammer which made that thing look like a peashooter. She practiced with it every day. To protect your farm, I believe?</i>” You pause and look her dead in the eye. “<i>If I remember right, after I finished with her, she was a whimpering mess. How well has she been fighting since, because the way I see it, there isn’t much protecting your farm these days. Just about anyone could walk in here and do as they please. As you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}
			else
			{
				outputText("\n\n“<i>Cute. But I’ve fought things that had dicks which looked deadlier than that thing.</i>” You pause and look her dead in the eye. “<i>I’ve fought a lot of things since I arrived here, Whitney. Crushed a lot of things underneath my heel. All of Mareth is coming to understand that if you are not useful to me, you are broken and remade so that you </i>are<i>. It would be a damn shame if something like that happened to you because you wouldn’t see sense. After all, just about anyone could walk in here and do as they please, as you sleep, perhaps? Quietly taint your food whilst you work? Are you really going to hold onto that crossbow for the rest of your life?</i>” Whitney’s grip is trembling slightly, you can see it in the bolt and string.");
			}

			outputText("\n\n“<i>What do you want?</i>” she growls in a strangled voice.");

			outputText("\n\n“<i>All I want is to... maximise this farm’s productivity. There’s a lot of slack around here that needs picking up, if you ask me.</i>” You put your hands behind your back and begin to slowly pace back and forth in the pepper patch. She’s still pointing the crossbow, but the arrow’s barb is getting increasingly erratic. “<i>You will let me use the farm as I please. I will send... help... to you, as I see fit. In return, I guarantee that I will not make any attempts on your person, and I guarantee that no harm will come to your farm.</i>” The barb trembles for a while longer. ");

			// if PC has Kelly or PC raped Marble
			if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 || player.findStatusAffect(StatusAffects.MarbleRapeAttempted) >= 0)
			{
				outputText("\n\nYou have to admit, it’s going to be plenty painful if she fires it, so much so that you don’t know what will happen afterwards; an image of an inferno consuming a barn flits through your mind. After what seems like an hour of deliberation, though, Whitney lowers the crossbow.");

				outputText("\n\n“<i>Alright. Alright, maybe you got me, stranger. Without");
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >=  4) outputText(" Kelt");
				else outputText(" Marble");
				outputText(" I cannot properly protect the place, so maybe I do need... insurance.</i>” She spits the last word. “<i>Just so long as you stay the fuck away from me, I will do as you say.</i>” You beam.");
			}
			else
			{
				// if Marble is at the Farm
				if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) < 0 && player.findStatusAffect(StatusAffects.NoMoreMarble) < 0)
				{
					outputText("\n\n“<i>Marble will not stand for it,</i>” Whitney says, her voice barely above a whisper.");

					outputText("\n\n“<i>Marble can fucking swivel,</i>” you reply calmly. “<i>I outnumber her.</i>”");
				}

				// if Kelt is still around
				// (Kelt being disabled doesn't remove him from the farm iirc, so it's literally just if Kelt != Kelly)
				if (flags[kFLAGS.KELT_BREAK_LEVEL] < 4)
				{
					outputText("\n\n“<i>Do you think Kelt will take you muscling in on his territory? He’ll kill you before letting that happen.</i>”");

					outputText("\n\n“<i>If Kelt is willing to take direction from someone like you he will take it from me, I think,</i>” you say, shrugging casually. “<i>If you think I’m frightened of that moronic blowhard you’ve got another thing coming.</i>”");
				}

				outputText("\n\nYou have to admit, it’s going to be plenty painful if she fires it, so much so that you don’t know what will happen afterwards; an image of an inferno consuming a barn flits through your mind. After what seems like an hour of deliberation, though, Whitney lowers the crossbow.");

				outputText("\n\n“<i>Alright. Alright, maybe you got me, stranger. I don’t have eyes in the back of my head, so maybe I do need... insurance.</i>” She spits the last word. “<i>Just so long as you stay the fuck away from me, I will do as you say.</i>” You beam.");
			}

			outputText("\n\n“<i>Smart decision. I’ll send along help to you as soon as I can. I look forward to a long and prosperous business relationship with you.</i>” You bow deeply, turn and move almost all the way to the gate before raising a finger. “<i>Oh, just one more thing. I will be expecting a cut. Seeing as how I’m invested in your little operation now and all. Shall we say 20%? If you cannot bear giving me the money yourself, just leave it underneath the rock over yonder every week. Do that and we won’t have any... problems.</i>” You smirk at her. She looks at you as if she’s never seen you before in her life, incapable of words. “<i>I guess that’s settled then. Always a pleasure talking to you, Whitney.</i>” You throw your [hips] out in an exaggerated swagger as you slowly make your way back to camp, knowing the dog morph’s eyes will follow you until you disappear into the distance.");

			flags[kFLAGS.FARM_CORRUPTION_STARTED] = 1;
			
			doNext(13);
		}
		
		protected function takeoverPromptLater():void
		{
			clearOutput();
			
			outputText("You stare for a moment longer, then turn and head back to camp. You will show mercy she does not deserve... for now.");
			
			doNext(13);
		}
		
		protected function takeoverPromptNever():void
		{
			clearOutput();
			
			outputText("You close your eyes and take deep, shuddering breaths, drawing in the sweet, grass scented air and listening to the quiet, gentle peace which surrounds this place. The putrid ideas and viciously colourful images crowding your mind fade bit by bit, your blood cools and slowly, eventually, you find inner tranquillity.  You promise yourself that come what may you’ll never do anything to this patch of peace you found in this world so long ago, if only as a reminder of what you once were. A heavy lump gathering in your throat, you turn and leave.");
 
			// (Option never displayed again, -5 Corruption)
			dynStats("cor-", 5);
			doNext(13);
		}
		
		public function rootScene():void
		{
			clearOutput();
			spriteSelect(62);
			
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 2)
			{
				flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 3;

				outputText("“<i>[name]? [name]!</i>” You turn and watch Whitney shyly step out from the shadow of the barn. She has retained her slim frame and modest clothes, however her fur is all gone and has been replaced by skin of the same sandy colour. Human feet peek out from underneath her skirt, and... well. You take a few moments to drink in her human face, still quintessentially Whitney in her long, delicate features, thin but easy smile and rosy colour accentuating her high cheekbones; pretty but not beautiful. The only dog features she has kept are her floppy ears and short, perky tail. Scratch that; as you smile approvingly she smiles widely in return, laughing almost in relief, revealing quite pointed teeth and a thinner-than-normal tongue. Still, it’s a pretty decent effort all round.");

				outputText("\n\n“<i>Very good girl,</i>” you say. You slowly approach her. “<i>Such swiftness and willingness to change is an excellent sign. You and I will go very far together indeed.</i>” Again you stand directly in front of her, again you stare deep into her brown eyes; you wait until her breath comes shallow once more. “<i>Now, where were we?</i>”");

				doNext(dontDeFurDoge);
				return;
			}

			// Whitney not corrupt
			if (!whitneyCorrupt())
			{
				outputText("You stand on the rise you’ve taken to using to look down on the farm which you are invested in.")
				
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) outputText(" A large machine, bulky and rotund with a conical top, has been built into the milking barn. Fat pipes crawl up onto the roof from it like metal ivy, and white smoke billows busily out of its whistle chimney.");
				
				if (flags[kFLAGS.FARM_UPGRADES_CONTRAPCEPTIVE] == 1) outputText(" Next to the pepper patch another crop has been planted, a field of verdant green shrubs. Their thin stems bob idly in the breeze.");
			}
			else
			{
				outputText("You stand on your rise and take in your slave farm. ");
				if (silly)
				{
					outputText(player.mf("You feel an irresistible hankering for a cigar.", "You feel an irresistible hankering for a cigarette holder.");
				}
				if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) outputText(" A large machine, bulky and rotund with a conical top, has been built into the milking barn. Fat pipes crawl up onto the roof from it like metal ivy, and white smoke billows busily out of its whistle chimney.");
				if (flags[kFLAGS.FARM_UPGRADES_CONTRAPCEPTIVE] == 1) outputText(" Next to the pepper patch another crop has been planted, a field of verdant green shrubs. Their thin stems bob idly in the breeze.");
			}

			// [Follower taster and “blessing” text goes here]
			
			// Ceraphs Influence
			if (flags[kFLAGS.FOLLOWER_AT_FARM_CERAPH] > 0)
			{
				outputText("\n\nThere is an indefinable aura of corruption slathered across the farm; you can taste it at the back of your throat, you can practically see it like a blaze on your retina from looking at a purple light too long. The area has definitely been marked by a demon.");
			}
			
			// Holli Influence
			if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] > 0)
			{
				outputText("\n\nThe crops and grass which surround you seem to blaze with life, almost feverishly so. Suggestively shaped vines have curled up one or two of the trees, and some of the wildflowers look... different. Holli’s blessing has caused everything on the farm to grow faster, but if you peer closely at the grass at your feet, you can make out the purple tendrils of corruption within.");
			}
			
			// Amily
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1)
			{
				outputText("\n\nAmily is in the pepper patch with a trowel happily beavering away. If she wasn’t purple and naked apart from her work gloves it would be difficult to believe she was corrupt at all.");
				
			}
			
			// Jojo
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1)
			{
				outputText("\n\nYou cannot see Jojo but you have no doubt he was aware of your presence the moment you arrived, and that he’s somewhere nearby, watching.");
			}
			
			// Bimbo Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2)
			{
				outputText("\n\nYou cannot see Sophie but distinctive coos and giggles are coming from the hen coop.");
			}
			
			// Regular Sophie
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1)
			{
				outputText("\n\nSophie has put together a huge nest on top of the hen coop from which she pensively stares out at the lake. When she sees you looking she brightens noticeably and begins to preen her plumage.");
			}
			
			// Izma
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1)
			{
				outputText("\n\nIzma is sitting in Whitney’s old spot below the oak tree, curled up in a book.");
			}
			
			// Isabella
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1)
			{
				outputText("\n\nIsabella is hauling steel canisters in and out of the milking barn, singing merrily to herself as she does.");
			}
			
			// Vapula
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1)
			{
				outputText("\n\nVapula is slouched against a barn wall, looking like the world’s grumpiest one woman gang. Not even a number of comatose imps nearby seem to have been able to cheer her up.");
			}
			
			// Latexy
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1)
			{
				outputText("\n\nYou can see something black shimmering wetly underneath Whitney’s porch which could only be a certain latex goo.");
			}
			
			// BathSlut
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
			{
				if (flags[kFLAGS.MILK_SIZE] > 0)
				{
					outputText("\n\n[Bathgirlname] is rather predictably in the cow shed, milking the cattle. She looks tan, bright and happy; the country air is doing her good.");
				}
				else
				{
					outputText("\n\n[Bathgirlname] is sat on the edge of her tank next to the cow shed, rubbing her huge tits in slow, mesmeric patterns. Her gaze is vacant except when it lands on you, whereon it becomes hopeful.");
				}
			}
			
			farmMenu();
		}
		
		public function farmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] == 0)
			{
				if (!whitneyCorrupt()) addButton(0, "Whitney", dogeNotCorruptYet);
				else addButton(0, "Whitney", dogeCorruptedMissionComplete);
			}

			if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 0) addButton(0, "Whitney", dogeNotCorruptYet);
			else addButton(0, "Whitney", whitneyCorruptMenu);
			
			if (player.findStatusAffect(StatusAffects.MarbleRapeAttempted) < 0 && player.findStatusAffect(StatusAffects.NoMoreMarble) < 0 && player.findStatusAffect(StatusAffects.Marble) >= 0 && flags[kFLAGS.MARBLE_WARNING] == 0) addButton(1, "Marble", farm.meetMarble);
			
			if (player.findStatusAffect(StatusAffects.Kelt) >= 0 && player.findStatusAffect(Keltoff) < 0)
			{
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) addButton(2, "Kelly", farm.kelly.breakingKeltOptions);
				else if (flags[kFLAGS.KELT_BREAK_LEVEL] > 0 && flags[kFLAGS.KELT_TALKED_FARM_MANAGEMENT] == 0) addButton(2, "Kelt", keltAChangeInManagement);
				else addButton(2, "Kelt", farm.kelly.breakingKeltOptions);
			}
			
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") >= 0) 
			{
				if (player.findStatusAffect(StatusAffects.Milked) >= 0) 
				{
					outputText("\n\n<b>Your " + nippleDescript(0) + "s are currently too sore to be milked.  You'll have to wait a while.</b>", false);
				}
				
				addButton(3,"Get Milked", farm.getMilked);
			}
			
			if(player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") >= 0 && player.cockTotal() > 0)
			{
				addButton(4,"Milk Cock", farm.cockPumping);
			}
			
			addButton(5, "Farm", corruptingTheFarmExplore);
			
			if (slavesAtFarm()) addButton(6, "Slaves", slavesAtFarmMenu);
			if (loversAtFarm()) addButton(7, "Lovers", loversAtFarmMenu);
			if (followersAtFarm()) addButton(8, "Followers", followersAtFarmMenu);
			
			addButton(9, "Leave", eventParser, 13);
		}
		
		private function corruptingTheFarmExplore():void
		{
			menu();
			
			addButton(0, "Explore", farm.exploreFarm);
			
			addButton(1, "Collect", collectTheGoodies);
			
			addButton(9, "Back", farmMenu);
		}
		
		private function keltAChangeInManagement():void
		{
			clearOutput();
			
			outputText("“<i>Hear there’s been a change in management,</i>” says Kelt, clopping to a halt in front of you. You confirm that that is the case. The big centaur looks at you thoughtfully. There’s something different in his dark eyes and rugged scowl than his usual wearied contempt. Grudging admiration?");

			outputText("“<i>Find it difficult to believe someone like you could put a bitch in her place,</i>” he says eventually. “<i>Perhaps you’ve got bigger balls than I thought you had."); 
			if (player.balls == 0) outputText(" So to speak, anyway.");
			outputText("</i>” He snorts, and trots towards the butts. “<i>Just don’t expect me to treat you any different. As long as you’re getting free instruction from me, I’m the master and you’re the whelp. Got that?</i>”");
			
			outputText("\n\nYou reply evenly you can get along with that, and he’s welcome to stay on at the farm, but if he lays a finger on any of your own slaves you’re going to break every bone in his hands. Kelt roars with laughter.");

			outputText("“<i>Do I look like I want or need your sloppy seconds? Godsdamn, I can only imagine what kind of pathetic creatures would have </i>you<i> lording it over them. What a joke! Now, are we going to go watch you fail miserably to hit a target from five yards or what?</i>”");

			outputText("It’s better than you were expecting from him in all honesty. You take your bow out and silently follow him to the archery range.");
			
			flags[kFLAGS.KELT_TALKED_FARM_MANAGEMENT] = 1;
			
			doNext(13);
		}
		
		private function numSlavesAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) count++;

			return count;
		}

		private function slavesAtFarm():Boolean
		{
			if (numSlavesAtFarm() > 0) return true;
		}

		private function slavesAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1) addButton(0, "Amily", kGAMECLASS.amilyScene.amilyFollowerEncounter);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1) addButton(1, "Jojo", kGAMECLASS.jojoScene.corruptCampJojo);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2) addButton(2, "Sophie", kGAMECLASS.sophieBimbo.approachBimboSophieInCamp);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) addButton(3, "Vapula", kGAMECLASS.vapula.callSlaveVapula);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) addButton(4, flags[kFLAGS.GOO_NAME], kGAMECLASS.latexGirl.approachLatexy);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) addButton(5, flags[kFLAGS.MILK_NAME], kGAMECLASS.milkWaifu.milkyMenu);
			
			addButton(9, "Back", farmMenu);
		}
		
		private function numFollowersAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) count++;

			return count;
		}

		private function followersAtFarm():Boolean
		{
			if (numFollowersAtFarm() > 0) return true;
		}

		private function followersAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 1) addButton(0, "Sophie", kGAMECLASS.sophieFollowerScene.followerSophieMainScreen);
			
			addButton(0, "Back", farmMenu);
		}
		
		private function numLoversAtFarm():int
		{
			var count:int = 0;

			if (flags[kFLAGS.FOLLOTER_AT_FARM_IZMA] > 0) count++;
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] > 0) count++;

			return count;
		}

		private function loversAtFarm():Boolean
		{
			if (numLoversAtFarm() > 0) return true;
		}

		private function loversAtFarmMenu():void
		{
			menu();
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1) addButton(0, "Izma", kGAMECLASS.izmaScene.izmaFollowerMenu);
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 2) addButton(0, "Izmael", eventParser, 9999);
			
			if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) addButton(1, "Isabella", kGAMECLASS.isabellaFollowerScene.callForFollowerIsabella);
			
			addButton(0, "Back", farmMenu);
		}

		private function dogeNotCorruptYet():void
		{
			clearOutput();
			whitneySprite();

			flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] = 1;

			// Farm Corruption drops below 30 after being higher: 
			if (whitneyCorruption() < 30 && flags[kFLAGS.WHITNEY_CORRUPTION_HIGHEST] > 30 && flags[kFLAGS.WHITNEY_CORRUPTION_0_30_DROP_MESSAGE] == 0)
			{
				outputText("You hail Whitney as she hauls a bag of grain towards the storage barn. She entirely ignores you; there’s an expression of cold triumph on her face as she breezes past you, color high in her cheeks. You notice that she’s rediscovered her crossbow and has it strapped to her back. It hurts your eyes slightly to look at her, as if she’s standing directly in front of the sun. You scowl at her retreating back. You’ll have to do something about this.");

				// [Plays once, reverts to standard message]
				flags[kFLAGS.WHITNEY_CORRUPTION_0_30_DROP_MESSAGE] = 1;
				
				if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) doNext(dogeNotCorruptLeaveFirstTime);
				else doNext(13);

				return;
			}

			// 0-30 Farm Corruption
			if (whitneyCorruption() <= 30)
			{
				flags[kFLAGS.FARM_CORRUPTION_APPROACHED_WHITNEY] = 1;
				outputText("You find Whitney sat in the cow field, hand milking one of her herd; her crossbow is propped up against a bucket. As you approach, she looks up sharply before slowly reaching for the weapon. You stop in your tracks, and she stops in kind, her hand frozen on the grip. You take a step forward and she picks it up, her finger finding the trigger, her expression entirely emotionless. You take several hasty steps back, she puts it down and goes back to milking peacefully.");

				outputText("\n\nYou wave in exasperation and leave; if that’s the way she wants it. If she’s working with you and your followers for any length of time, she’ll have to loosen up eventually.");

				if (flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) doNext(dogeNotCorruptLeaveFirstTime);
				else doNext(13);

				return;
			}

			// 31-60 Farm Corruption
			if (whitneyCorruption() >= 31 && whitneyCorruption() <= 60)
			{
				if (flags[kFLAGS.WHITNEY_MENU_31_60] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_31_60] = 1;

					outputText("Once again you approach Whitney, this time as she is carrying full buckets of milk towards the bottling station. She sees you coming and quickens her step. You notice this time however she doesn’t have her crossbow, and this emboldens you.");

					outputText("\n\n“<i>You can’t ignore me for the rest of your life!</i>” you yell. “<i>Let me talk to you about the farm, at least! I’m invested in this place, I’m throwing help at it and the owner won’t even tell me what she actually needs!</i>” Whitney slows to a halt, and then after a long moment sighs, puts the buckets down and turns.");

					outputText("\n\n“<i>Alright,</i>” she mutters. You notice her eyes are red and raw at the edges. “<i>I’m gettin sick of this game too. I cannot pretend you and your servants ain’t here, so I guess I gotta face reality, as piss unpleasant as it is, and talk to you about the wheres and whys of it.</i>” She shudders involuntarily, and then lifts her eyes reluctantly to yours. “<i>What do you want to talk about?</i>”");
				}
				else
				{
					// Subsequent 31-60: 
					outputText("Whitney puts down her work as you stride towards her, resigned unhappiness in her expression.");

					outputText("\n\n“<i>What is it?</i>”");
				}

				// [Unlocks Whitney main menu]
				dogeNotCorruptYetMenu();
				return;
			}

			if (whitneyCorruption() >= 61 && whitneyCorruption() <= 90)
			{
				if (flags[kFLAGS.WHITNEY_MENU_61_90] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_61_90] = 1;

					// 61-90 Farm Corruption
					outputText("You find Whitney on the steps of the porch to her small house, adjoined to the storage barn. There’s a book next to her but she is simply sat drinking in the sun, her eyes closed. When she opens them and sees you standing there she smiles at you wanly; it’s the first time you’ve seen her do that for some time. There is something indefinable in her gaze and the long lines of her face: trepidation perhaps, coated patchily with coyness.");

					outputText("\n\n“<i>Hello [name],</i>” she says softly. “<i>Something on your mind?</i>”");
				}
				else
				{
					// 61-90 Subsequent: 
					outputText("Whitney puts down her work and smiles at you vaguely as you approach her. You again sense that queasy mixture of anxiety, unhappiness and excitement in her jerky, cramped movements and expression.");

					outputText("\n\n“<i>Hello [name]. Is there something you want?</i>”");
				}

				dogeNotCorruptYetMenu();
				return;
			}

			if (whitneyMenu() >= 91 && whitneyMenu() <= 119)
			{
				// 91-119 Farm Corruption
				if (flags[kFLAGS.WHITNEY_MENU_91_119] == 0)
				{
					flags[kFLAGS.WHITNEY_MENU_91_119] = 1;

					outputText("There is a sultry atmosphere around the farm these days. The air feels warmer than it should and the breeze which curls over the fields carries with it a musky, enticing perfume which presses irresistibly into your nose and the back of your throat. When you find Whitney on her porch you can’t help but think she looks considerably more relaxed than she has done of late; perhaps it’s just too hard to remain tense in these conditions. ");

				outputText("\n\n“<i>Yes, [name],</i>” she says, so softly you can barely hear her. “<i>What can I do for you?</i>” Cautiously, you ask her how she feels about the changes you have made around the farm.");

				outputText("\n\n“<i>You were right,</i>” she says, again in that incredibly low voice, before clearing her throat and going on in a louder tone, the words spilling out of her. “<i>I hated you when you first came here demanding a share of the farm, more than anything I’ve ever hated in a long time. Someone taking control of my family’s farm, what I had worked on for all these years, through what seemed to me like pure vindictiveness… I fantasized about killing you, didja know that? Shooting you through the neck when you were tendin’ to something else. The only thing that stopped me I think was fear: fear that you were so powerful that you’d survive it somehow. How miserable I was back then... but at some point I just said fuck it, you know? If I couldn’t work up the courage to fight you, what was the point in stayin’ miserable and angry the whole time? And the more I let go of it...</i>”");

				outputText("\n\nAs she talks, you delve into your pocket and bring out a gem, this time with deliberate slowness. Whitney’s eyes are immediately drawn to it and she pauses; you softly motion for her to continue, slowly turning the small, glittering kaleidoscope in your fingers as you do. “<i>...It’s just so much more </i>fun<i> around here these days. The farm feels like it’s alive, I am makin so much more money and... the more I open my mind, the more I let go of those old hates, the more I can think, the more I can feel. Gods, I am feeling things I haven’t in years. I see the way you order your followers around and it feels powerful, I make them do as I will and it feels right, like I’m taking control and shaping the world instead of just layin back and watchin it pass me by. It feels like... like...</i>”");

				outputText("\n\n“<i>Like you’re waking up,</i>” you say. You twist the gem back and forth, shining tiny, scattering beams of blinding light into the dog morph’s eyes. Her mouth hands open and her breath is shallow. “Like since I’ve taken control you’ve woken up to everything that life has to offer, everything that </i>I<i> have to offer, the horizons that appear when you submit to my will. This farm is many times the place it was when you were closed up in your old life of petty certainties. You just told me that and like the farm, </i>you<i> are becoming more and more real the further you open yourself to me.”");

				outputText("\n\nYou think the doggie is close now, so very close to fully opening her mind and entirely tasting reality. All she needs to do is one thing to demonstrate her commitment....");

				outputText("\n\n”<i>What is that,</i>” says Whitney dully. You smile, gently bringing the twisting gem to a halt and putting it back into your pouch. You will know what that is when you are truly ready, you say. With that you turn and leave her, swaying vaguely on the porch, her eyes far, far away. As long as you can keep her immersed in the atmosphere you’ve conjured up over the farm, you think she’ll be ready for the final stage of your plan soon enough.");
				}
				else
				{
					// Subsequent 91-119: 
					outputText("Whitney lays down her work eagerly as you approach. ");

					outputText("\n\n“<i>What’re you after, [name]?</i>” she says, smiling. There’s a barely contained excitement in her eyes; you don’t think she realises her short tail is wagging furiously.");
				}

				dogeNotCorruptYetMenu();
				return;
			}

			if (whitneyCorruption() == 120)
			{
				if (flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] == 0)
				{
					flags[kFLAGS.WHITNEY_CORRUPTION_COMPLETE] = 1;
					
					// 120 Farm Corruption 
					outputText("You don’t need to seek out Whitney this time; almost the moment you arrive on the farm a sandy furred figure is hurrying over to you. There’s deep excitement in her face and her breast is heaving with more than just exertion.");

					outputText("\n\n“<i>[name], can I... can I talk to you? I really need t-to talk.</i>” You know what she’s really asking for here. You smile, withdraw the gem and once again begin to slowly turn it, clockwise, then anti-clockwise... Whitney’s eyes are full of reflected, sparkling light.");

					outputText("\n\n“<i>You won’t ever leave here, will you?</i>” she says breathlessly. “<i>I-I’ve started thinking things, so many delicious </i>things<i>, and I... I’m worried they’ll stop when you do. You promise you won’t stop coming around?</i>” You say coolly that your continued involvement depends on her telling you exactly what she’s been thinking about. Whitney pauses for a moment and then goes on. Her mouth is so dry you struggle not to swallow in sympathy.");

					outputText("\n\n“<i>It started as a joke - I started giving orders to your followers like you do. You been around here enough it’s easy to imitate your words ‘n tone. That made ‘em start! But then I... I began to fantasise about really owning them, about abusing them, about beating them and then making em thank me for the privilege. Because they deserve it, don’t they? That’s what they are there for. That’s how you think and Gods... it feels so right to think that way, it opens up so many possibilities. But then I began to think in a new way....</i>” She licks her lips unconsciously. “<i>When you were around, again just for jokes I’d look at you and call you somethin’ under my breath, and </i>that<i>... every time I did it I had to go, I had to go somewhere quiet an’...</i>” she is unable to continue.");

					outputText("\n\nSoftly, still spinning the gem, you ask her what she called you. Whitney makes a noise which is familiar to you but which you’ve never heard emanating from her; a faint, high pitched whine from the back of her throat. Again, gently but firmly, you ask her what word she used.");

					outputText("\n\n“<i>...[Master],</i>” she says, quietly. You smile triumphantly. It’s time to move onto the final stage of your high-stakes business merger, however such is your control over the dog morph now you could make her change for you, if you so wished.");

					///[Defur][Get on with it]
				}
			}
		}

		private function dogeNotCorruptLeaveFirstTime():void
		{
			clearOutput();
			whitneySprite();

			flags[kFLAGS.WHITNEY_LEAVE_0_60] = 1;

			// Leave first time: [otherwise defaults to main farm menu] 
			outputText("As you turn to leave, you feel something tug on your [armor]. You turn back to look into Whitney’s searching eyes.");

			outputText("\n\n“<i>How... how do you do it?</i>” she asks haltingly. “<i>How can you force other people into becoming your... your puppets, your chattel? Doesn’t it sicken your stomach?</i>” You shrug nonchalantly and say that almost all of your harem had ideas about your personal freedom, your genitals, and how they would use them to fuel their own selfish purposes; your will and desires simply proved to be stronger than theirs. You have discovered through hard experience that that is the way of this world and those who think otherwise are simply prey to those who are more ruthless. You stare for a moment longer into her eyes, and then sweep away.");

			doNext(rootScene);
		}

		private function dogeNotCorruptLeave6190():void
		{
			clearOutput();
			whitneySprite();

			flags[kFLAGS.WHITNEY_LEAVE_61_90] = 1;

			// Leave first time: 
			outputText("“<i>I know what you’re tryin to do,</i>” the dog woman says abruptly as you conclude your business and turn to leave. “<i>You think that if you make me work with your slaves, poison this place with your influence and demon magic, you’ll turn me into one of your puppets too. Evil osmosis, or somethin.</i>” She laughs bitterly. There’s an almost hysterical note to it. Maybe you’re kidding yourself but you think there might also be a brittle, perverse note of excitement in there too. “<i>It don’t work like that. All you’re doing with this business is surroundin me with examples of your cruelty, of what corruption and ill-will can do to ordinary folks. I can stand against it, and I will.</i>”");

			outputText("\n\nYou shrug nonchalantly, retrieve a gem from your purse and spin it on your fingertips with the same affected casualness. It’s not about corruption, you say; you aren’t in league with the demons, you have a soul. All you want to do is make the very best of this farm, and open her mind to new possibilities, new ways of thinking. The gem glitters with sunlight as you spin it rhythmically. You think that she’s spent too long on her own; has become so set in her ways she sees anything that changes her world as a threat, even if it is for her own benefit. She should open her eyes and open her mind to the success you’re bringing to her fields; maybe she’d learn how rich life can be if she let go of her prejudices, and accept that from your wider experience you know better. You pinch the gem to a stop and look at Whitney. She stares at the pretty object a moment longer before shaking her head and bringing her eyes up to yours, slightly dazed. You turn and leave, smiling quietly to yourself.");
		}

		private function dogeNotCorruptYetMenu():void
		{
			menu();

			addButton(0, "Appearance", whitneyAppearanceNotCorrupt);
			addButton(1, "Prosperity", prosperityGoNotCorrupt);
			addButton(2, "Investment", investmentGoNotCorrupt);

			addButton(9, "Back", rootScene);

			if (whitneyCorruption() <= 60 && flags[kFLAGS.WHITNEY_LEAVE_0_60] == 0) addButton(9, "Back", dogeNotCorruptLeaveFirstTime);
			else if (whitneyCorruption() <= 90 && flags[kFLAGS.WHITNEY_LEAVE_61_90] == 0) addButton(9, "Back", dogeNotCorruptLeave6190);
		}

		private function whitneyAppearanceNotCorrupt():void
		{
			clearOutput();
			whitneySprite();

			outputText("\n\nWhitney is a 5’8” dog morph, dressed in a modest cotton blouse and faded long skirt, which has a hole cut in it to allow her short, perky tail to poke through. Her muzzle is suggestive of a golden retriever but really she could be any breed. Her fur is sandy, dusking to black at her extremities. Her ears are floppy, her eyes are a dark brown which matches her shoulder-length hair. She is beyond the flush of youth, however it is obvious from looking at her that she has never known childbirth; though hardened from many years of farm work her frame is relatively slim, her hips and ass widened only with muscle, her small breasts pert against her unprepossessing work-clothes. She has one anus, nestled between her tight buttcheeks where it belongs.");

			dogeNotCorruptYetMenu();
			addButton(0, "", null);
		}

		private function prosperityGoNotCorrupt():void
		{
			clearOutput();
			whitneySprite();

			outputText("You ask her how the help is coming on.");

			var lowProtection:Boolean;
			var lowValue:Boolean;

			if (farmProtection() < 12) lowProtection = true;
			if (farmValue() < 12) lowValue = true;

			// Value low, Protection low:
			if (lowValue && lowProtection) outputText("\n\nShe shrugs exasperatedly. “<i>I used to get by just fine on my own,</i>” she says. “<i>‘Til you started demanding 20% of everything. You think gems grow on cornstalks? Send me any kind of decent body - someone, anyone - and I can start trying to make more-a this place.</i>”");

			// Value high, Protection low: 
			if (!lowValue && lowProtection) outputText("\n\n“<i>You’ve given me lots’ve good workers, lots’ve good earners, and I’ve been bringing in lots’ve produce.</i>” She sighs. “<i>The trouble is lots’ve produce attracts trouble. Imps, gnolls, that sort. And if there ain’t nobody to stop em, they help themselves. I need strong types to come along here, warriors, watchers, people who’ll stop stuff disappearing in the night. You know?</i>”");

			// Value low, Protection high: 
			if (lowValue && !lowProtection) outputText("\n\n“<i>Feel plenty safe at night, I can tell you that. You got this place protected better than a bank vault.</i>” Whitney shrugs. “<i>Trouble is, the vault is empty. Guards ‘d be great but they don’t scratch the earth for a living. I need hard workers, people who’ll produce stuff, earners. That’s what this place is crying out for right now.</i>”");

			// Value high, Protection high: 
			if (!lowValue && !lowProtection) outputText("\n\n“<i>Difficult to complain. This place is doing better than I’ve ever known, even going back to my grandma’s day. As long as we keep up this level of hard work and security, we’ll keep making this kinda scratch.</i>” You look at her, unsmiling, and she is momentarily thrown. “<i>It’s not.... You aren’t-? Well, the only way we’d earn more money is- but I’d never…</i>” she trails off, not looking at you.");

			dogeNotCorruptYetMenu();
			addButton(1, "", null);
		}

		private function investmentMenu():void
		{
			menu();
			if (player.hasKeyItem("Breast Milker - Installed At Whitney's Farm") < 0 && flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] == 0) addButton(0, "Breast Milker", investmentBreastMilker);
			if(player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0 && flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] == 0) addButton(1, "Cock Milker", investmentCockMilker);
			if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 0 && flags[kFLAGS.QUEUE_REFINERY_UPGRADE] == 0) addButton(2, "Refinery", investmentRefinery);
			if (flags[kFLAGS.FARM_UPGRADES_CONTRACEPTIVE] == 0 && flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] == 0) addButton(3, "Contraceptive", investmentContraceptive);
			if (flags[kFLAGS.FARM_UPGRADES_MILKTANK] == 0 && kGAMECLASS.milkWaifu.milkSlave() && flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] == 0) addButton(4, "MilkTank", investmentMilktank);

			if (whitneyCorrupt()) addButton(9, "Back", dogeNotCorruptYetMenu);
			else addButton(9, "Back", dogeCorruptedMissionComplete);
		}

		private function investmentBreastMilkerNotCorrupt():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You say you’d like a breast milker installed, one that you could make use of. Whitney frowns, but doesn’t seem as thrown by this idea as you expected.");

				outputText("\n\n“<i>I have a few spare parts knockin around, but most everything will have to be specially ordered if you want that,</i>” she says. “<i>If you can pony up 1000 gems, I can get what you need brought in, built, and installed.</i>”");
			}
			else
			{
				outputText("You say you’d like a breast milker installed, one that you could make use of. Whitney lets her gaze sink down to your [chest].");

				outputText("\n\n“<i>Want to get closer to nature, [master]?</i>” she says, grinning slyly. “<i>I have a few spare parts knockin around, but most everything will have to be specially ordered if you want it. If you can pony up 1000 gems, I can get what you need brought in, built, and installed.</i>”");
			}

			//[Do it][No]
			menu();
			if (player.gems >= 1000) addButton(0, "Do it", doBreastMilkerInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doBreastMilkerInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 1000;

			outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

			outputText("\n\n“<i>Should have that ready to go by tomorrow, if y’all come back then.</i>”");

			flags[kFLAGS.QUEUE_BREASTMILKER_UPGRADE] = 1;

			doNext(13);
		}

		private function investmentCockMilker():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You say you’d like a semen extractor built, one that you could make use of. Whitney frowns, but doesn’t seem as thrown by this idea as you expected.");

				outputText("\n\n“<i>I have a few spare milkin parts knockin around, but most everything will have to be specially ordered if you want that,</i>” she says. “<i>If you can pony up 1000 gems, I can get what you need brought in, built, and installed.</i>”");
			}
			else
			{
				outputText("You say you’d like a semen extractor built, one that you could make use of. Whitney bites her lip at the implication.");

				outputText("\n\n“<i>I have a few spare milkin parts knockin around, but most everything will have to be specially ordered if you want that, [master],</i>” she says. “<i>If you can pony up 1000 gems, I can get what you need brought in, built, and installed.</i>”");
			}

			menu();
			if (player.gems >= 1000) addButton(0, "Do it", doCockMilkerInvestment);
			else addButton(0, "Do it", turnDownInvestment, true)
			addButton(1, "No", turnDownInvestment);
		}

		private function doCockMilkerInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 1000;

			if (!whitneyCorrupt())
			{
				outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

				outputText("\n\n“<i>Should have that ready to go by tomorrow, if y’all come back then.</i>”");
			}
			else
			{
				outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

				outputText("\n\n“<i>Should have that ready to go by tomorrow, [master]!</i>”");
			}

			flags[kFLAGS.QUEUE_COCKMILKER_UPGRADE] = 1;

			doNext(13);
		}

		private function investmentRefinery():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You say you want a machine built that could concentrate the fluids your followers produce into actual transformatives. Whitney shudders, but is in no position to argue.");

				outputText("\n\n“<i>A refinery, then? I guess it wouldn’t be too hard to throw up a still of sorts and adapt it from there. It’ll cost money though, ‘ticularly if you want it to be used by anyone for anything. If you give me 1500 gems, I kin see what I kin do.</i>”");
			}
			else
			{
				outputText("You say you want a machine built that could concentrate the fluids your followers produce into actual transformatives.");

				outputText("\n\n“<i>A refinery, [master]? What a delicious thought.</i>” The dog girl closes her eyes and drifts off into an erotic reverie. You wait patiently until she finally opens her eyes with a sigh and comes back to you. “<i>I guess it wouldn’t be too hard to throw up a still of sorts and adapt it from there. It’ll cost money though, ‘ticularly if you want it to be used by anyone for anything. If you give me 1500 gems, I ‘kin see what I ‘kin do.</i>”");
			}

			menu();
			if (player.gems >= 1500) addButton(0, "Do it", doRefineryInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doRefineryInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 1500;

			outputText("You silently hand over a hefty bag of gems. Whitney stows it away.");

			outputText("\n\n“<i>I will try and get... that... ready in a few days time, if y’all come back then.</i>”");

			flags[kFLAGS.QUEUE_REFINERY_UPGRADE] = 1;

			doNext(13);
		}

		private function investmentContraceptive():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				outputText("You ask Whitney if she knows of any natural contraceptive that grows in Mareth.");

				outputText("\n\n“<i>The stuff that some of the sharks use, y’mean? Sure. You find it growing in clumps in loamy patches in the forest and along the lake. Most nobody in those parts uses it o’course, owing to them all being locked in a baby arms race with each other.</i>” You say you’d like her to set some land aside and grow it. “<i>If you want. I need seed though, and plenty of compost - only grows in very moist soil as I said. 750 gems can probably make it happen.</i>”");
			}
			else
			{
				outputText("You ask Whitney if she knows of any natural contraceptive that grows in Mareth.");

				outputText("\n\n“<i>The stuff that some of the sharks use, y’mean? Sure. You find it growing in clumps in loamy patches in the forest and along the lake. Most nobody in those parts uses it o’course, owing to them all being locked in a baby arms race with each other.</i>” You say you’d like her to set some land aside and grow it. “<i>If you want, [master]. I need seed though, and plenty of compost- only grows in very moist soil as I said. 750 gems can probably make it happen.</i>”");
			}

			menu();
			if (player.gems >= 750) addButton(0, "Do it", doContraceptiveInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doContraceptiveInvestment():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 750;

			if (!whitneyCorrupt())
			{
				outputText("You hand over the dough. Whitney stows it away.");

				outputText("\n\n“<i>It doesn’t take long to grow, but it’ll still take time,</i>” she says. “<i>I’ll lay the seeds tomorrow and you’ll be able to start pickin it in a week’s time.</i>”");
			}
			else
			{
				outputText("You hand over the dough. Whitney stows it away.");

				outputText("\n\n“<i>It doesn’t take long to grow, but it’ll still take time, [master],</i>” she says. “<i>I’ll lay the seeds tomorrow and you’ll be able to start pickin’ it in a week’s time.</i>”");
			}

			//[“Harvest Contraceptive” option added to main farm menu in 7 days time]
			flags[kFLAGS.QUEUE_CONTRACEPTIVE_UPGRADE] = 1;
			doNext(13);
		}

		private function investmentMilktank():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				// If Bathgirl normal:
				if (flags[kFLAGS.MILK_SIZE] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
				{
					outputText("You tell Whitney you want her to give [bathgirlName] an intensive course of Gro-plus and Lactaid, and to build a small swimming tank to house her.");

					outputText("\n\n“<i>Wh-what?</i>” says the dog woman, aghast. “<i>The pretty lil’ thing who works in the cowshed? She told me you cured her. She’s so happy an, an now you want to... uncure her?</i>” ");

					outputText("\n\nExactly, you say primly. You need her to produce more milk. Whitney looks like she’s going to refuse, but once she’s stared into your unblinking eyes and remembered a few things, she looks at her feet and sighs miserably. “<i>I could probably do that. Because she trusts you, she trusts me, and- 400 gems,</i>” she finishes in a mumble.");
				}
				// If Bathgirl boobed and at camp: 
				else
				{
					outputText("You tell Whitney you want her to build a swimming tank at the farm, then come to your camp, take away your expensively acquired milk slave and install her in it. The dog woman slowly absorbs this.");

					outputText("\n\n“<i>400 gems,</i>” she says finally.");
				}
			}
			else
			{
				if (flags[kFLAGS.MILK_SIZE] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1)
				{
					outputText("You tell Whitney you want her to give [bathslutName] an intensive course of Gro-plus and Lactaid, and to build a small swimming tank to house her.");

					outputText("\n\n“<i>[Master] you are so wicked,</i>” the dog woman whispers with overt glee. “<i>Pumpin that silly slut full of growth hormones ‘til all she can think about are her big, juicy tits- oh Gods, gimme gems, 400 should do it, I want to start right now!</i>”");
				}
				else
				{
					outputText("\n\nYou tell Whitney you want her to build a swimming tank at the farm before coming to your camp, taking away your expensively acquired milk slave and installing her in it. ");

					outputText("\n\n“<i>Of course, [master],</i>” says Whitney, a grin creeping onto her face at the prospect of another slave under her thumb. “<i>400 gems’ll make it happen.</i>”");
				}
			}

			menu();
			if (player.gems >= 400) addButton(0, "Do it", doMilktalkInvestment);
			else addButton(0, "Do it", turnDownInvestment, true);
			addButton(1, "No", turnDownInvestment);
		}

		private function doMilktankInvestment():void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt()) outputText("You press the gems into your taskmaster’s hand, turn and leave without another word. Your thoughts turn to huge, delightfully plush brown boobs and luxurious milky baths; it will be well worth it. ");
			else outputText("You press the gems into your taskmaster’s hand, turn and leave without another word. Your thoughts turn to huge, delightfully plush, brown boobs, of luxurious milky baths; it will be well worth the cost. ");

			// In each case Bath girl reverts to her boobed state and is at farm
			flags[kFLAGS.QUEUE_MILKTANK_UPGRADE] = 1;

			doNext(13);
		}

		private function turnDownInvestmentNotCorrupt(money:Boolean = false):void
		{
			clearOutput();
			whitneySprite();

			if (!whitneyCorrupt())
			{
				// Any “No” option:
				outputText("Whitney shrugs, nonplussed.");

				if (money) outputText("\n\n“<i>Come back with the money.</i>”");
				else outputText("\n\n“<i>Come back if you change your mind. With the money.</i>”");
			}
			else
			{
				outputText("Whitney shrugs with a simper. ");

				outputText("\n\n“<i>Come back any time if ya change your mind, [master]. S’long you got the money, it won’t be hard to do.</i>”");
			}

			investmentMenu();
		}

		private function deFurDoge():void
		{
			clearOutput();
			whitneySprite();

			outputText("You put away the gem and move into Whitney, holding her gaze as you gently place your finger and thumb along her jaw line. She doesn’t pull away and lets out a shuddering sigh as you touch her.");

			outputText("\n\n“<i>I’m glad you have finally opened your mind to everything I can do for you, understood what our relationship truly is,</i>” you say. “<i>And I’m ready to teach you all sorts of things. However…</i>” you pinch into her muzzle very slightly and Whitney tenses, unable to tear her gaze away from your eyes. “<i>This isn’t acceptable. Walking, talking animals are an aberration in my eyes. And you know what happens to aberrations, don’t you Whitney?</i>” She doesn’t reply; she’s deep under your influence, deep under your words. “<i>But you’re a smart girl. A girl who has worked with transformatives her whole life. So I’ll come back tomorrow, and you will be different, in a more suitable form, and then we will discuss your exciting new future properly. Ok?</i>”");

			outputText("\n\n“<i>‘s,</i>” says Whitney, very quietly. You smile at her warmly, and release your grip.");

			outputText("\n\n“<i>Good girl.</i>” You turn and leave.");

			//[“Whitney” option removed from farm menu until next day]
			flags[kFLAGS.WHITNEY_DISABLED_FOR_DAY] = 1;
			flags[kFLAGS.WHITNEY_DEFURRED] = 1;

			doNext(13);
		}

		private function dontDeFurDoge():void
		{
			clearOutput();
			whitneySprite();

			outputText("“<i>I told you there was something you had to do, to demonstrate you fully understood your new reality,</i>” you say, your gaze boring into hers. Whitney’s lips begin to form words, but you ride roughshod over them. “<i>I think you know what it is.</i>” She blinks a couple of times, comprehension dawning on her face, before silently turning and heading towards her house. Whilst she is gone, you stride over to the woodpile to retrieve what you yourself will need for this.");

			outputText("\n\nWhitney pauses when she sees the hatchet resting on your shoulder; she clutches the object she holds in her own hands tighter.");

			outputText("\n\n“<i>Give it here,</i>” you say softly. Whitney is still for a while longer, her eyes fixed on the axe, and you wonder for a moment if you will have to reach for the gem again. However, with a long, shuddering sigh, she holds it out for you of her own accord. Your hands touch as you take her crossbow; she is blazing with heat.");

			outputText("\n\nYou take a moment to consider the weapon. It’s not a bad piece at all. It looks well balanced, its wood burnished, string well greased, the bolt sharp and of obvious quality- you notice it’s got ‘Tel’Adre Guard’ stamped into its handle. You carefully place it on the ground and then approach Whitney. She tenses but does not resist when you stand behind her and take her by the wrists, pushing into her firmly. You stay like that for a long time, your breath in her ear, enjoying her heat and thumping pulse against your [chest] and arms, your groin against her tight ass, waiting for her to relax. When she eventually does so, you push the hatchet into her hands. Her grip closes on the handle and with only a slight amount of resistance you push her wrists upwards with your own hands. You stop applying any force when the hatchet is hovering over her head, but maintain hold of her wrists.");

			outputText("\n\n“<i>Now... who does the farm belong to?</i>” you say quietly into her ear. Whitney is frozen in the stance you’ve steadily pushed her into for what seems like an eternity, the two of you a tableau of anticipated violence. Then, finally, with a whistling gasp, she brings the hatchet down with a splintering crash on the crossbow, hard enough that it wedges halfway into the grip.");

			outputText("\n\n“<i>You,</i>” she mumbles. She stares downwards and then uses her foot to free the blade. “<i>It belongs to you.</i>” Again you grip her wrists and raise the hatchet above her head.");

			outputText("\n\n“<i>And who am I?</i>” you murmur. A second’s pause, and the hatchet comes hurtling down. It’s a more calculated blow this time, and most of the crossbow’s handle goes flying off into the long grass.");

			outputText("\n\n“<i>[Master],</i>” she says, louder this time. “<i>You are this farm’s [master], and y-you are my [master]!</i>” You hold her tight and grind your");
			if (player.hasCock()) outputText(" crotch into");
			else outputText(" hips against");
			outputText(" her firm ass and she moans, her breath starting to come in shallow gulps, her heart beating furiously against your skin. Although you keep hold of her you don’t have to do anything to make the hatchet rise again.");

			outputText("\n\n“<i>Very good,</i>” you say, continuing to press your own hot, measured breath into her floppy ear. “<i>So if I’m the [master], what would that make you?</i>” The hatchet head is a grey streak in the air and then the string is broken, the bolt smashed and the stock dented.");

			outputText("\n\n“<i>I am... I am your slave!</i>” she cries out. “<i>I own nothing, I don’t want to own nothing i-if it means I can belong to you!</i>” She suddenly breaks free of your grasp and hurls herself with a vengeance at what remains of the weapon, howling and growling as she lifts the hatchet again and again, splintered wood flying as she destroys her old life, her last defence against you in a purging frenzy. You stand and watch the display with a broad smile. You really are too good sometimes.");

			outputText("\n\nWhen Whitney turns back to you, heaving with exertion, colour high in her face, her hair and clothes dishevelled, there’s something new in her eyes; what were once the most placid pools of hazel are now lit and marbled with a deep, red desire. You have immersed the dog girl in an atmosphere of corruption for so long it seems as if all you had to do at this point was throw the right switch.");

			outputText("\n\n“<i>Did that please [master]?</i>” she says, grinning.");

			outputText("\n\n“<i>Very much so,</i>” you reply as you continue to consider her. It occurs to you that you have caused both dominant and submissive tendencies to bubble to the surface of her psyche during her transformation; although you are now indisputably the overall master of her and her farm, in her vulnerable state now it would only take a few words and actions to make her act one way or the other towards you sexually.");

			///[Make Sub][Make Dom]
			menu();
			addButton(0, "Make Sub", makeDogeSubby);
			addButton(1, "Make Dom", makeDogeDommy);
		}

		private function makeDogeSubby():void
		{
			clearOutput();
			whitneySprite();

			outputText("You again retrieve your gem, and once more begin to rhythmically turn it; this time, however, you walk steadily towards Whitney, your voice getting louder in her ears and the shining light in her unfocused eyes getting brighter as you go on.");

			outputText("\n\n“<i>Felt good to do that, didn’t it? To do away with the idea you could stop me, to be entirely open and defenceless to me. Because you are defenceless to me now, aren’t you Whitney?</i>” As you talk, you stop rotating the jewel but continue to hold it directly in front of her eyes, whilst you place your other hand on her hip, sliding it upwards, enjoying the firm contours of your new slave.");

			outputText("\n\nShe whines as you roam far enough upwards to slip underneath the belt of her skirt and then downwards again, smoothing around her tight rump and inner thigh until you touch her labia. It is not surprising to you to find that she is dripping wet, her underclothes soaked with excitement. You gently push your fingers into the wet heat and begin to stroke her inner lips, curving upwards to find and caress her tiny clit as you continue to talk, pressing your compulsion on her as you drown her hypnotised mind in pleasure.");

			outputText("\n\n“<i>You are my bitch, and you will act like it. You will protect my property with your life, and run it to the very best of your abilities. You will put my other slaves to the lash, make them work twice as hard just so you may receive one word of praise from me. When you hear my voice, it will make you wet.");

			if (player.biggestTitSize() >= 2) outputText("\n\nWhen you see my breasts, you will want to suckle on them.");

			if (player.hasCock()) outputText("\n\nWhen you see my dick, you will want to worship it.");

			if (player.hasVagina()) outputText("\n\nWhen you see my cunt, you will want to bathe it in attention.");

			outputText("\n\nAs long as you’re a good girl, you will be my right hand here, and good girls get treats. Bad girls get punished.</i>” Whitney is panting, her eyes unable to look away from the gleaming gem as you stick two fingers into her tight hole and begin to masturbate her briskly. “<i>Now... what are you?</i>” The dog girl’s cunt spasms around your fingers deliriously, and your whole hand is soaked in a sudden gush of fluid.");

			outputText("\n\n“<i>Good... girl!</i>” manages the former farm owner between groaning breaths. You slowly take both hands away, and wait for her eyes to refocus on you.");

			outputText("\n\n“<i>Demonstrate it.</i>” Immediately Whitney sinks down on her knees before you, brown eyes looking up soulfully. You smile widely, and press your hand onto her head.");

			outputText("\n\n“<i>GOOD girl!</i>” She grins happily and her tail wags furiously as you rub her behind the ear. “<i>That’s how I expect to find you every time I come to visit. Now run along, go and make my farm spin gold. I will be along later to see if you need rewarding or punishing.</i>”");

			outputText("\n\n“<i>At once, [master]!</i>” The dog girl is on her feet and off towards the farm in one swift movement, new determination etched into her posture. Your take-over of the farm is complete; you should expect to see a larger share of the profits now Whitney is your slave taskmaster, entirely bent on serving you.");

			doNext(13);
		}

		private function makeDogeDommy():void
		{
			clearOutput();
			whitneySprite();

			outputText("You again retrieve your gem, and once more begin to rhythmically turn it. This time, however, you walk steadily towards Whitney, your voice getting louder in her ears, the shining light in her unfocused eyes getting brighter as you go on.");

			outputText("\n\n“<i>You liked doing that, didn’t you Whitney? That letting go, that burst of pure violence, passion given physical form. You always had that within you, but for some reason you chose to bury it, stifle it under a life of complete tedium. Until </i>I<i> came along. Until </i>I<i> I gave you slaves to order around and forced those desires to the surface, an unquenchable thirst to overcome and make your own.</i>”");
 
			outputText("\n\nAs you talk, you stop rotating the jewel but continue to hold it directly in front of her eyes, whilst you place your other hand on her hip, sliding it upwards, enjoying the firm contours of your new slave. The dog girl’s eyes are not unfocused this time; they are staring into the blinding light with a hard, sheer lust, her breath drawing harshly as your hand continues to move. You find your heart quickening at the prospect of what you are about to do; but the thought of fanning those embers of furious passion you have kindled within this once calm woman is too enticing to resist.");

			outputText("\n\nHer breath comes harder as you roam far enough upwards to slip underneath the belt of her skirt and then downwards again, smoothing around her tight rump and inner thigh until you touch her labia. You are not surprised to find that she is dripping wet, her underclothes soaked with excitement. You gently push your fingers into the sopping heat and begin to stroke her inner lips, curving upwards to find and caress her tiny clit as you continue to talk, pressing your compulsion on her as you drown her hypnotised mind in pleasure.");

			outputText("\n\n“<i>It’s so good that I came along and opened your mind to those sensations isn’t it, slave? And you want to thank me in any way you can, don’t you?</i>”");

			outputText("\n\n“<i>Yes,</i>” she breathes, her mouth open, unable to tear her hardened eyes away from the gem.");

			outputText("\n\n“<i>Good. Because I have use for those passions of yours. You will use them to work my other slaves twice as hard, you will put them to the lash until they beg you for mercy, and then you will do it some more just because it gives you pleasure. An absolute bitch, that’s what you will become. My bitch. The hand I use to keep my harem in line. Can you be that for me, Whitney? Are you strong enough? Or are you going to be another mewling slut I need to constantly discipline?</i>”");

			outputText("\n\n“<i>No,</i>” she says, gritting her teeth. Her breath comes ragged as you stick two fingers into her tight hole and begin to masturbate her briskly. “<i>I can be that. I want to be your right hand, I want the other slaves to cower in the dirt before me, I want to drill ‘em to better serve you. I want - I need that!</i>”");

			outputText("\n\n“<i>I will let you become that,</i>” you say softly, “<i>if you do exactly as I order.</i>”");

			outputText("\n\n“<i>Yes!</i>” You say nothing for a short while as you continue to frig her, breathing in the wild scent which permeates the air around you as you dip your fingers up to the base in her tight hole, licking and curling at her until she is panting. You speak next as you feel the urgency of impending climax grip her muscles.");

			outputText("\n\n“<i>So if,</i>” you whisper, “<i>your master ordered you to release your passions on [him], would you do that?</i>” Incomprehension wrinkles Whitney’s brow for a single moment before being replaced by a euphoric dawning of understanding, an epiphany of lust.");

			outputText("\n\n“<i>Yes,</i>” she pants, the light shining from the gem reflected back at you as hard lust, as she begins to buck her hips frantically against your hand. “<i>Gods, yes I would. I would be strong for [master]... I would become [his] taskmaster, train his cattle to the very best of my abilities... just so I could learn how to take... </i>very<i>... good care of [master]!</i>” She punctuates each growled word with thrusts against your fingers, her cunt spasming deliriously around them, and your whole hand is soaked in a sudden gush of fluid. You slowly withdraw both your hands and wait for her eyes to refocus on you. The fire there is undiminished.");

			outputText("\n\n“<i>Good,</i>” you say quietly. “<i>Because the most hardworking of " + player.mf("masters", "mistresses") + " need some R and R from time to time. A bit of private alone time, with a very trusted slave. A slave who would know not to betray the confidence placed in them, because of all the examples surrounding her of how far she could fall if she did. You following me?</i>”");

			outputText("\n\n“<i>You’ve broken something open in me I never knew existed,</i>” says Whitney fervently between ragged, sighing breaths. “<i>And then given me a life which I will goddang love every minute of. I want to use it to love you and touch you and fuck you and make you cry out in ways you never knew existed with it. It’s all I want, [master], let me show you just how much you can trust me!</i>” She is possessed by a nervous energy, her fingers twitching, as if she’s repressing an urge to grab you only with immense difficulty. You smile at her softly.");

			outputText("\n\n“<i>Later. There will be an endless later, now you have fully opened your mind to me. For now... run along, go and make my farm spin gold.</i>”");

			outputText("\n\n“<i>At once, [master]!</i>” The dog girl turns and is off towards the farm in one swift movement, new determination etched into her posture. Your take-over of the farm is complete; you should expect to see a larger share of the profits now Whitney is your slave taskmaster, entirely bent on serving you.");


			flags[kFLAGS.WHITNEY_DOM] = 1;

			doNext(13);
		}

		private function dogeCorruptedMissionComplete():void
		{
			if (flags[kFLAGS.QUEUE_BRANDING_AVAILABLE_TALK] == 1)
			{
				brandingAvailableTalk();
				return;
			}

			menu();
			addButton(0, "Appearance", corruptWhitneyAppearance);
			addButton(1, "Investment", investmentMenu);
			if (flags[kFLAGS.FARM_CORRUPTION_BRANDING_MENU_UNLOCKED] == 1 || flags[kFLAGS.QUEUE_BRANDING_UPGRADE] < 1) addButton(2, "Branding", brandingMenu);
		}

		private function corruptWhitneyAppearance():void
		{
			outputText("\n\nWhitney is a 5’8” dog ");
			if (whitneyDefurred()) outputText(" girl");
			else outputText(" morph")
			outputText(".");

			if (whitneyDefurred()) outputText(" Her muzzle is suggestive of a golden retriever but really she could be any breed.");
			else outputText(" Her human transformation has rendered her pretty in a delicate, diffident kind of way.");

			if (whitneyDefurred()) outputText(" In sharp contrast to her otherwise fairly thin features, her lips are plump and a depthless black, shining like wet tar. She constantly moves her tongue over them unconsciously.");

			outputText("\n\nAlthough she continues to dress in the same modest cotton blouses and long skirts she always has, complete with holes cut in to allow her short, perky tail to poke through, the cut of it and the way she moves and swings herself about, livid with arousal and near-constant sexual frustration, makes the demure outfit more perverse than anything a demon could dream up.");

			if (whitneyHasTattoo())
			{
				outputText("\n\nShe has ");
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE]);
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0 && flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) outputText("; ");
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS]);
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0 && (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0 || flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0)) outputText("; ");
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0) outputText(flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK]);
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0 && (flags[kFLAGS.WHITNEY_TATTO_LOWERBACK] != 0 || flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0 || flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0)) outputText("; ");
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0) outputText(flags[kFLAGS.WHITNET_TATTOO_BUTT]);
			}

			if (!whitneyDefurred()) outputText("\n\nHer fur is sandy, dusking to black at her extremities.");
			else outputText("\n\nHer skin is a sandy colour, and she wears black nail varnish.");

			outputText(" Her ears are floppy, her eyes are a dark brown which matches her shoulder-length hair, flecked now with deep, red desire. Whilst she is beyond the softness of youth, it is obvious from looking at her that she has never known childbirth; though hardened from many years of farm work her frame is relatively slim, her small breasts pert against her unprepossessing work-clothes. She has one anus, between her tight asscheeks where it belongs.");

			dogeCorruptedMissionComplete();
			addButton(0, "", null);
		}

		private function brandingMenu():void
		{
			clearOutput();
			whitneySprite();

			if (flags[kFLAGS.FARM_CORRUPTION_BRANDING_MENU_UNLOCKED] == 0)
			{
				outputText("\n\nYou idly put an arm around Whitney, drawing her into you. You want her in the right frame of mind before you lead her down this path of inquiry. Her breath is hot and heavy against your [chest], her desire-lit eyes unable to tear away from yours as your hand slides down the curve of her back and round around her enjoyably tight ass. You ask her what she knows about branding.");

				outputText("\n\n“<i>I don’t brand my herd, [master],</i>” she says in a low voice, as you smooth your hand upwards and slip your fingers underneath her skirt. “<i>’s a very cruel practice and without any other farms round there’s no need for it anyway.</i>” But surely she must know of ways to mark cattle, you go on. Ways to make it immediately clear who owns them. You put not-so-subtle emphases on certain words as you touch her sopping vagina, slipping two fingers in easily. “<i>Mayhap... mayhap I do, [master],</i>” the dog woman groans, her breath coming in gulps and hisses as your digits move in her warm wetness. “<i>Somethin’, somethin’ from my granddaddy’s day. If you give me 500 gems and some time, I could... go and make a few things happen...</i>”");

				menu();
				if (player.gems >= 500) addButton(0, "Do it", getBrandingStuff);
				else addButton(0, "Do it", dontGetBrandingStuff);
				addButton(1, "No", dontGetBrandingStuff);
			}
			else
			{
				clearOutput();

				outputText("Your thoughts turn to the ingenious magic of your tattooing gear, stashed away in the barn. Grinning, you consider who you will summon to brand.");

				if (player.gems < 50) outputText("\n\n<b>You don't have enough gems to afford a new brand for any of your slaves.</b>");

				menu();

				if (player.gems >= 50)
				{
					if (hasFreeTattooSlot("whitney")) addButton(0, "Whitney", brandWhitney);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 1 && hasFreeTattooSlot("amily")) addButton(1, "Amily", brandAmily);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 1 && hasFreeTattooSlot("jojo")) addButton(2, "Jojo", brandJojo);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 2 && hasFreeTattooSlot("sophie")) addButton(3, "Sophie", brandBimboSophie);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 1) && hasFreeTattooSlot("vapula")) addButton(4, "Vapula", brandVapula);
					if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 && hasFreeTattooSlot("kelly")) addButton(5, "Kelly", brandKelly);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1 && flags[kFLAGS.MILK_SIZE] > 0 && hasFreeTattooSlot("milky")) addButton(6, flags[kFLAGS.MILK_NAME], brandSmallMilky);
					if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1 && flags[kFLAGS.MILK_SIZE] == 0 && hasFreeTattooSlot("milky")) addBUtton(6, flags[kFLAGS.MILK_NAME], brandBigMilky);

				addButton(9, "Back", dogeCorruptedMissionComplete);
			}
		}

		private function hasFreeTattooSlot(name:String):Boolean
		{
			if (name == "whitney")
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "amily")
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "jojo")
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "sophie")
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "vapula")
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "kelly")
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else if (name == "milky")
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] == 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] == 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] == 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_BUTT] == 0) return true;
				return false;
			}
			else
			{
				throw new Error("Unable to determine correct NPC flags.");
			}
		}

		public function hasTattoo(name:String):Boolean
		{
			if (name == "whitney")
			{
				if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "amily")
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.AMILY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "jojo")
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.JOJO_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "sophie")
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "vapula")
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "kelly")
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.KELLY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else if (name == "milky")
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] != 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] != 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] != 0) return true;
				if (flags[kFLAGS.MILKY_TATTOO_BUTT] != 0) return true;
				return false;
			}
			else
			{
				throw new Error("Unable to determine correct NPC flags.");
			}
		}

		private function brandWhitney():void
		{
			clearOutput();
			whitneySprite();

			outputText("Whitney knows exactly what it means when you head off to the barn where she stashed your “branding” equipment; the dog girl is already eagerly stripped down by the time you’ve returned. You hold the pots of ink and consider where, and what, to put on her.");

			player.gems -= 50;

			brandSlotSelect();
		}

		private function brandAmily():void
		{
			clearOutput();

			outputText("You retrieve the pots of ink and paper from the barn and, smiling, tell your pet mouse you’re going to give her a treat.");

			outputText("\n\n“<i>How exciting!</i>” she squeaks. “<i>Is it your");
			if (player.hasCock()) outputText(" dick");
			else if (player.hasVagina()) outputText(" pussy");
			else outputText(" body");
			outputText(", [master]? That’s my favourite type of treat.</i>” You consider where, and what, to put on her.");

			player.gems -= 50;

			amilyBrandSlotSelect();
		}

		private function brandJojo():void
		{
			clearOutput();

			outputText("You retrieve the pots of ink and paper from the barn and, smiling brightly, tell your pet mouse you’re going to give him a special treat. Jojo knows all too well the nature of your treats. He closes his eyes and waits for the worst as you consider where and what to put on him.");

			player.gems -= 50;

			jojoBrandSlotSelect();
		}

		private function brandBimboSophie():void
		{
			clearOutput();

			outputText("You retrieve the pots of ink and paper from the barn and, smiling, tell your pet harpy you’re going to give her a treat.");

			if (!hasTattoo("sophie"))
			{
				outputText("\n\n“<i>Oh wow like cool, a tattoo kit!</i>” she says excitedly, her eyes fastening immediately on what you’re carrying. “<i>Where did you get that, babe? I’ve been looking like all over for one of those.</i>” How on Mareth could she possibly...? You’re beginning to suspect bimbo liqueur contains a more profound magic than you originally assumed.");

				outputText("\n\nShaking your head, you consider where and what you’re going to put on her.");
			}
			else
			{
				outputText("\n\n“<i>More super sexy tats, [name]?</i>” the harpy beams. “<i>Awesome!</i>”");

				outputText("\n\nShaking your head, you consider where and what you’re going to put on her.");
			}

			player.gems -= 50;

			bimboSophieSlotSelect();
		}

		private function brandVapula():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and, smiling, tell your succubus you’re going to give her a treat.");

			outputText("\n\n“<i>What’s that supposed to be, [name]?</i>” she says, peering at your tools. “<i>Tattooing gear? Wow, that’s crude. You know Lethice has artists whose pens make you feel whatever is drawn on you, so….</i>” You say you don’t give a stuff what Lethice has, you’re here now and you going to tattoo exactly what you like on her.");

			outputText("\n\n“<i>Hhh, I love it when you get all forceful, [master],</i>” Vapula purrs. She narrows her eyes at you provocatively. “<i>Treat me then. I’ve been ever so good.</i>”");

			outputText("\n\nYou consider where and what you’re going to put on her.");

			player.gems -= 50;

			vapulaSlotSelect();
		}

		private function brandKelly():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and smilingly tell your centaur cumslut you’re going to give her a treat.");

			outputText("\n\n“<i>Ok,</i>” she says meekly, her wide, green eyes on the objects in your hand. “<i>It won’t hurt, will it?</i>” Like you fucking her in the ass, you tell her soothingly, any initial pain will be more than worth the eventual satisfaction. As she blushes rosily, you consider where and what you’re going to put on her.");

			player.gems -= 50;

			kellySlotSelect();
		}

		private function brandSmallMilky():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and, smiling kindly, tell your ex Sand Witch slave you’re going to give her a treat. ");

			outputText("\n\n[bathgirlName] looks at your tattooing paraphernalia apprehensively.");

			outputText("\n\n“<i>Skin pictures? O-ok, I guess.</i>” She breaks her brittle display of casualness with a laugh. “<i>I’ve always quite liked butterflies - You don’t see them out in the desert much. If you’re going to draw something - maybe you could...?</i>”");

			player.gems -= 50;

			smallMilkySlotSelect();
		}

		private function brandBigMilky():void
		{
			outputText("You retrieve the pots of ink and paper from the barn and, smiling kindly, tell your ex Sand Witch slave you’re going to give her a treat. ");

			outputText("\n\n[bathgirlName] blinks up at you, and then frowns hard as she considers this.");

			outputText("\n\n“<i>Bath time?</i>” she eventually replies.");

			player.gems -= 50;

			bigMilkySlotSelect();
		}

		private function getBrandingStuff():void
		{
			clearOutput();
			whitneySprite();

			player.gems -= 500;

			outputText("You stroke at her tiny, bulging button relentlessly until she releases a wordless bark of ecstasy, soaking your hand with a gratifyingly large gush of femcum. As she pants into your chest you wipe one hand clean on her clothes and press the money into her [paws/hands] with the other.");

			outputText("\n\n“<i>Make it happen,</i>” you murmur into her floppy ear, before turning and leaving.");

			flags[kFLAGS.QUEUE_BRANDING_UPGRADE] = 1;

			doNext(13);
		}

		private function dontGetBrandingStuff():void
		{
			clearOutput();
			whitneySprite();

			outputText("You stroke at her tiny bulging button until you adjudge she’s on the edge, before withdrawing your hand completely. Maybe some other time, you say airily.");

			outputText("\n\n“<i>Oh [master],</i>” groans Whitney, in a tone of deepest exasperation, her hands between her thighs.");
			if (whitneyDom()) outputText(" “<i>You’ll pay for that later, I swear!</i>”");
			outputText(" Grinning, you turn and leave.");

			dogeCorruptedMissionComplete();
		}

		private function brandingAvailableTalk():void
		{
			clearOutput();
			whitneySprite();

			outputText("“<i>[Master]! [Master], I’ve done as you asked,</i>” says Whitney, her tail wagging frantically as you approach. Her eyes are lit with glee and she’s got a cow with her on tether. You settle down and watch as she produces unassuming pots of black and red ink, and a sheaf of what looks like blotting paper.");

			outputText("\n\n“<i>Thought nobody sold this stuff anymore,</i>” she says with a shake of the head as she unstops a vial. A sharp, solvent smell presses into your nostrils. “<i>But it’s amazing what you kin’ find in that bazaar place, ain’t it? Watch.</i>” She dips a long ");
			if (whitneyDefurred()) outputText(" fingernail");
			else outputText(" claw");
			outputText(" into the pot, withdraws it and then, dripping black fluid, presses it against the cow’s ample backside. The animal moos and swishes its tail in mild protest, but it doesn’t seem in any grievous amount of pain as Whitney’s digit moves, artfully tracing a large number 12 with the ink.");

			outputText("\n\n“<i>Then we take some of the paper and press it on to seal it... like so….</i>” There’s a faint hissing sound as Whitney covers the 12 with the white sheet, but again the cow barely seems to notice. When she peels it off she gestures for you to take a look for yourself. This is probably the first and hopefully the last time you inspect a cow’s backside so scrupulously but you can only be impressed by what you see - the number is dried and apparently ingrained deep into the heavy flesh, resisting your own attempts to rub it off easily. This will suit your own purposes perfectly.");

			outputText("\n\n“<i>S’long as you know what you want and move yer finger carefully, you can tattoo anything on anything,</i>” says Whitney. “<i>‘S much easier to do than brandin’, and it’s magic that lasts for years an’ years.</i>” She pauses. She’s look at you with a sly, knowing grin. “<i>Perhaps you’d like to test it out for yourself, [master]?</i>”");

			flags[kFLAGS.QUEUE_BRANDING_AVAILABLE_TALK] = 0;

			menu();
			addButton(0, "Yes", testBranding);
			addButton(1, "No", dontTestBranding);
		}

		private function testBranding():void
		{
			clearOutput();
			whitneySprite();

			outputText("You return her devilish grin with interest.");

			outputText("\n\n“<i>Since you’ve been such a productive girl, I guess you do deserve a reward. Take your clothes off.</i>” ");

			outputText("\n\nThe dog girl eagerly strips whilst you carefully take the pot of black ink and consider where, and what, to put on her.");

			brandSlotSelect();
		}

		private var slotNames:Array = [
		"collarbone",
		"shoulders",
		"lower back",
		"butt" ];

		public function brandSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", brandSelect, 0)
			if (flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", brandSelect, 1);
			if (flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", brandSelect, 2);
			if (flags[kFLAGS.WHITNEY_TATTOO_BUTT] == 0) addButton(3, "Butt", brandSelect, 3);
		}

		public function amilyBrandSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", amilyBrandSelect, 0)
			if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", amilyBrandSelect, 1);
			if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", amilyBrandSelect, 2);
			if (flags[kFLAGS.AMILY_TATTOO_BUTT] == 0) addButton(3, "Butt", amilyBrandSelect, 3);
		}

		public function jojoBrandSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", jojoBrandSelect, 0)
			if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", jojoBrandSelect, 1);
			if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", jojoBrandSelect, 2);
			if (flags[kFLAGS.JOJO_TATTOO_BUTT] == 0) addButton(3, "Butt", jojoBrandSelect, 3);
		}

		public function bimboSophieSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", bimboSophieBrandSelect, 0)
			if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", bimboSophieBrandSelect, 1);
			if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", bimboSophieBrandSelect, 2);
			if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] == 0) addButton(3, "Butt", bimboSophieBrandSelect, 3);
		}

		public function vapulaSlotSelect():void
		{
			menu();
			if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", vapulaBrandSelect, 0)
			if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", vapulaBrandSelect, 1);
			if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", vapulaBrandSelect, 2);
			if (flags[kFLAGS.VAPULA_TATTOO_BUTT] == 0) addButton(3, "Butt", vapulaBrandSelect, 3);
		}

		public function kellySlotSelect():void
		{
			menu();
			if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", kellyBrandSelect, 0)
			if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", kellyBrandSelect, 1);
			if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", kellyBrandSelect, 2);
			if (flags[kFLAGS.KELLY_TATTOO_BUTT] == 0) addButton(3, "Butt", kellyBrandSelect, 3);
		}

		public function smallMilkySlotSelect():void
		{
			menu();
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", smallMilkyBrandSelect, 0)
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", smallMilkyBrandSelect, 1);
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", smallMilkyBrandSelect, 2);
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] == 0) addButton(3, "Butt", smallMilkyBrandSelect, 3);
		}

		public function bigMilkySlotSelect():void
		{
			menu();
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] == 0) addButton(0, "Collarbone", bigMilkyBrandSelect, 0)
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] == 0) addButton(1, "Shoulders", bigMilkyBrandSelect, 1);
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] == 0) addButton(2, "Lower Back", bigMilkyBrandSelect, 2);
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] == 0) addButton(3, "Butt", bigMilkyBrandSelect, 3);
		}

		public function brandSelect(slot:int):void
		{
			clearOutput();
			whitneySprite();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", tribalTattoo, slot);
			addButton(1, "Heart", heartTattoo, slot);
			addButton(2, "Property Of", propertyTattoo, slot);
			addButton(3, "#1 Bitch", no1Tattoo, slot);
			if (player.hasCock() && whitneyMaxedOralTraining())) addButton(4, "Cocksucker", champCocksuckerTattoo, slot);
			if (player.hasVagina() && whitneyMaxedOralTraining()) addButton(5, "Pussylicker", champPussylickerTattoo, slot);

			addButton(9, "Back", brandSlotSelect);
		}

		public function amilyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", amilyTribalTattoo, slot);
			addButton(1, "Heart", amilyHeartTattoo, slot);
			addButton(2, "Property Of", amilyPropertyTattoo, slot);
			addButton(3, "Breeding Bitch", amilyBreedingBitchTattoo, slot);
			if (player.hasCock() && slot == 2) addButton(4, "Cock Here", amilyCockGoesHereTattoo, slot);
			if (player.hasVagina()) addButton(5, "Mommy's Girl", amilyMommysGirlTattoo);

			addButton(9, "Back", amilyBrandSlotSelect);
		}

		public function jojoBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on his " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", jojoTribalTattoo, slot);
			addButton(1, "Heart", jojoHeartTattoo, slot);
			addButton(2, "Property Of", jojoHeartTattoo, slot);
			addButton(3, "Sissy Slut", jojoHeartTattoo, slot);
			if (pc.hasCock() && slot == 2) addButton(4, "Cock Here", jojoCockGoesHereTattoo, slot);
			if (pc.hasVagina()) addButton(5, "Mommy's Boy", jojoMommysBoyTattoo, slot);

			addButton(9, "Back", jojoBrandSlotSelect);
		}

		public function bimboSophieBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", bimboSophieTribalTattoo, slot);
			addButton(1, "Heart", bimboSophieHeartTattoo, slot);
			addButton(2, "Swallow", bimboSophieSwallowTattoo, slot);
			addButton(3, "Property Of", bimboSophiePropertyOfTattoo, slot);
			addButton(4, "Breeding Bitch", bimboSophieBreedingBitchTattoo, slot);
			if (slot == 3) addButton(5, "Wide Load", bimboSophieWideLoadTattoo, slot);
			if (player.hasCock() && slot == 2) addButton(6, "Cock Goes Here", bimboSophieCockGoesHereTattoo, slot);

			addButton(9, "Back", bimboSophieSlotSelect);
		}

		public function vapulaBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", vapulaTribalTattoo, slot);
			addButton(1, "Heart", vapulaHeartTattoo, slot);
			addButton(2, "Property Of", vapulaPropertyOfTattoo, slot);
			addButton(3, "Cum Addict", vapulaCumAddictTattoo, slot);
			if (slot == 2 || slot == 3) addButton(4, "Buttslut", vapulaButtslutTattoo, slot);
			if (!pc.hasCock()) addButton(5, "Dildo Polisher", vapulaDildoPolisherTattoo, slot);

			addButton(9, "Back", vapulaSlotSelect);
		}

		public function kellyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", kellyTribalTattoo, slot);
			addButton(1, "Heart", kellyHeartTattoo, slot);
			addButton(2, "Property Of", kellyPropertyOfTattoo, slot);
			addButton(3, "#1 Filly", kellyNo1FillyTattoo, slot);
			if (silly) addButton(4, "Dick Won", kellyDickWonTattoo, slot);
			if (slot == 1) addButton(5, "Horseshoe", kellyHorseshoeTattoo, slot);

			addButton(9, "Back", kellySlotSelect);
		}

		public function smallMilkyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", smallMilkyTribalTattoo, slot);
			addButton(1, "Heart", smallMilkyHeartTattoo, slot);
			addButton(2, "Butteryfly", smallMilkyButterflyTattoo, slot);
			addButton(3, "Property Of", smallMilkyPropertyOfTattoo, slot);
			addButton(4, "Bath Toy", smallMilkyBathToyTattoo, slot);
			if (slot == 0) addButton(5, "Mega Milk", smallMilkyMegaMilkTattoo, slot);
			if (slot == 0 && pc.hasCock()) "Cock Cozy", smallMilkyCockCozyTattoo, slot);

			addButton(9, "Back", smallMilkySlotSelect);
		}

		public function bigMilkyBrandSelect(slot:int):void
		{
			clearOutput();

			outputText("What will you draw on her " + slotNames[slot] + "?");

			menu();
			addButton(0, "Tribal", bigMilkyTribalTattoo, slot);
			addButton(1, "Heart", bigMilkyHeartTattoo, slot);
			addButton(2, "Property Of", bigMilkyPropertyOfTattoo, slot);
			addButton(3, "Bath Toy", bigMilkyBathToyTattoo, slot);
			if (slot == 0) addButton(4, "Mega Milk", bigMilkyMegaMilkTattoo, slot);
			if (slot == 0 && pc.hasCock()) addButton(5, "Cock Cozy", bigMilkyCockCozyTattoo, slot);

			addButton(9, "Back", bigMilkySlotSelect);
		}

		private function collarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. Your lithe, naked dog girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper.");
		}

		private function amilyCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. The succubus mouse does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function jojoCollarboneIntro():void
		{
			outputText("You command him to kneel in front of you and be still. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on him, and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says, when he looks down and sees what you’ve permanently inscribed on his chest. You tussle his adorable ears and tell him he’s quite welcome.");
		}

		private function bimboSophieCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. It’s difficult to get her to stay still, but she goes into a trance-like state when you finally lay your ink-soaked finger on her, mesmerised by its movement until you lay the paper over the design you’ve drawn and seal the ink.");
		}

		private function vapulaCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. The succubus does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function kellyCollarboneIntro():void
		{
			outputText("You command her to kneel in front of you and be still. The centaur does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function smallMilkyCollarboneIntro():void
		{
			outputText("You command her to take her clothes off, kneel in front of you and be still. The dusky girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her and then seal it on with the paper.");
		}

		private function bigMilkyCollarboneIntro():void
		{
			outputText("\n\nIt’s difficult getting at this area of [bathgirlName]’s anatomy, but you manage to crane yourself around her vast tits and get to work. Dipping your finger into the ink, you carefully draw your design on her skin and then seal it on with the paper. The former sand witch slave gazes down at what you’ve drawn mistily, trailing her fingers over it.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function shouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. Your lithe, naked dog girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. “<i>What did you draw, [master]?</i>” she says eagerly.");

			outputText("\n\nLaughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw no, come on, tell me what it is! It’s a rude word, isn’t it? [Master], it better not be somethin’ the slaves are gonna laugh at.</i>”");
		}

		private function jojoShouldersIntro():void
		{
			outputText("You command him to kneel facing away from you and be still. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on him, and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says. He pauses. “<i>I don’t suppose I could know what it-?</i>” You tussle his adorable ears and tell him of course not.");
		}

		private function amilyShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. Your succubus mouse does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her and then seal it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw [master], you know they’ll just lie and say it’s something like ‘breeding bitch’. C’mon, please tell me!</i>”");
		}

		private function bimboSophieShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. It’s difficult to get her to stay still, but she goes into a trance-like state when you finally lay your ink-soaked finger between her blonde wings, mesmerised by its movement until you lay the paper over the design you’ve drawn and seal the ink.");

			outputText("\n\n“<i>What did you put on?</i>” she says excitedly, turning around. “<i>Can I see?</i>” She turns around again. Her feathery brow furrows as she touches between her shoulder blades. She turns around again...");

			outputText("\n\nYou leave her to it.");
		}

		private function vapulaShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. Your succubus does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");

			outputText("\n\n“<i>Let’s have a look then,</i>” she sighs, sparks flying off her fingers as she magically forms a mirror trained on her back in her hands. “<i>Ah. Very nice, [name]. I look forward to the next time you mutilate my perfect body with your incredibly crude ideas and instruments.</i>” You intimate that next time you’ll simply draw a giant cock on her face, which does get a laugh from her.");
		}

		private function kellyShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. The centaur does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her shoulder blades, and then seal it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she asks tentatively when you’re done. Trying to keep a straight face, you say a giant spunky horse cock. “<i>That’s funny, [master]. Ha ha. Y-you didn’t really do that, did you?</i>”");
		}

		private function smallMilkyShouldersIntro():void
		{
			outputText("You command her to kneel facing away from you and be still. The dusky girl does so, keeping her back straight and still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper. ");
		}

		private function bigMilkyShouldersIntro():void
		{
			outputText("You set yourself down behind [bathgirlName] before dipping your finger into the ink, carefully draw your design on her, and then seal it on with the paper. She barely seems to notice.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function lowerbackIntro():void
		{
			outputText("You command her to set herself down on your [lowerBody], as if she were about to receive a spanking. Your lithe, naked dog girl does so, her laughter at her own compromising permission turning to a sharp coo as you dip your finger into the ink and carefully draw your design on her, before sealing it on with the paper. “<i>What did you draw, [master]?</i>” she says eagerly.");

			outputText("\n\nLaughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw no, come on, tell me what it is! It’s a rude word, isn’t it? [Master], it better not be somethin’ the slaves are gonna laugh at...</i>”");
		}

		private function jojoLowerbackIntro():void
		{
			outputText("You command him to set himself face down across your [legs], as if he were about to receive a spanking. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on him and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says. He pauses. “<i>I don’t suppose I could know what it-?</i>” You tussle his adorable ears and tell him of course not.");
		}

		private function amilyLowerBackIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. Your succubus mouse does so, her giggles at her own compromising position turning to a sharp coo as you dip your finger into the ink and carefully draw your design on her, before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw [master], you know they’ll just lie and say it’s something like ‘breeding bitch’. C’mon, please tell me!</i>”");
		}

		private function bimboSophieLowerBackIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. It’s difficult to get her to stay still, cooing and shaking with giggles at her compromising position. She finally falls into a trance-like state when you lay your ink-soaked finger on her, mesmerised by its movement until you lay the paper over the design you’ve drawn and seal the ink.");

 			outputText("\n\n“<i>What did you put on?</i>” she says excitedly, turning around. “<i>Can I see?</i>” She turns around again. Her feathery brow furrows as she touches her lower back. She turns around again...");

			outputText("\n\nYou leave her to it.");
		}

		private function vapulaLowerBackIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. Your succubus does so, her put-upon sigh turning to a sharp coo as you dip your finger into the ink and carefully draw your design on her, before sealing it on with the paper. ");

			outputText("\n\n“<i>Let’s have a look then,</i>” she says, sparks flying off her fingers as she magically forms a mirror trained on her back in her hands. “<i>Ah. Very nice, [name]. I look forward to the next time you mutilate my perfect body with your incredibly crude ideas and instruments.</i>”");

			outputText("\n\nYou intimate that next time you’ll simply draw a giant cock on her face, which does get a laugh from her.");
		}

		private function kellyLowerBackIntro():void
		{
			outputText("You command her to stand perfectly still.  She can’t quite stop clopping her hooves fretfully as you dip your finger into the ink and carefully draw your design on her human lower back before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she asks tentatively when you’re done. Trying to keep a straight face, you say a giant spunky horse cock. “<i>That’s funny, [master]. Ha ha. Y-you didn’t really do that, did you?</i>”");
		}

		private function smallMilkyLowerBackIntro():void
		{
			outputText("You command her to set herself down across your [legs]. The dusky girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her, and then seal it on with the paper.");
		}

		private function bigMilkyLowerBackIntro():void
		{
			outputText("You set yourself down behind [bathgirlName] before dipping your finger into the ink, carefully draw your design on her, and then seal it on with the paper. She barely seems to notice.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function buttIntro():void
		{
			outputText("You command her to set herself down on your [lowerBody], as if she were about to receive a spanking. Your lithe, naked dog girl does so, her laughter at her own compromising permission turning to a sharp coo as you dip your finger into the ink and carefully draw your design on the softest part of her anatomy, before sealing it on with the paper.");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw no, come on, tell me what it is! It’s a rude word, isn’t it? [Master], it better not be somethin’ the slaves are gonna laugh at. Ooh!</i>” You give her new tattoo a playful slap.");
		}

		private function amilyButtIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. Your succubus mouse does so, her laughter at her own compromising position turning to a sharp coo as you dip your finger into the ink and carefully draw your design on the softest part of her anatomy, before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she says eagerly. Laughing, you admire it for yourself and then say she’ll have to ask one of your other slaves... and hope they tell the truth. “<i>Aw [master], you know they’ll just lie and say it’s something like ‘breeding bitch’. C’mon, please tell me! Ooh!</i>” That tattoo is going to be pretty irresistible, you think, as you admire your red handprint over it.");
		}

		private function jojoButtIntro():void
		{
			outputText("You command him to set himself face down across your [legs], as if he were about to receive a spanking. The mouse-demon does so, staying perfectly still as you dip your finger into the ink, carefully draw your design onto the softest part of his body and then seal it on with the paper. ");

			outputText("\n\n“<i>Th-thanks, [master],</i>” he says. He pauses. “<i>I don’t suppose I could know what it-?</i>” You give his new tattoo a playful slap and tell him of course not.");
		}

		private function bimboSophieButtIntro():void
		{
			outputText("You command her to set herself face down across your [legs], as if she were about to receive a spanking. It’s difficult to get her to stay still, cooing and shaking with giggles at her compromising position. She finally falls into a trance-like state when you lay your ink-soaked finger on her, mesmerised by its movement until you lay the paper over the design you’ve drawn and seal the ink. You’ve certainly given yourself a vast if decidedly wobbly canvas to work on.");

			outputText("\n\n“<i>What did you put on?</i>” she says excitedly, turning around. “<i>Can I see?</i>” She turns around again. Her feathery brow furrows as she touches her butt. She turns around again...");

			outputText("\n\nYou leave her to it.");
		}

		private function vapulaButtIntro():void
		{
			outputText("You command her to set herself down across your [legs], as if she were about to receive a spanking. Your succubus does so, her put-upon sigh turning to a sharp coo as you dip your finger into the ink and carefully draw your design on the softest part of her anatomy, before sealing it on with the paper. ");

			outputText("\n\n“<i>Let’s have a look then,</i>” she says, sparks flying off her fingers as she magically forms a mirror trained on her ass in her hands. “<i>Ah. Very nice, [name]. I look forward to the next time you mutilate my perfect body with your incredibly crude ideas and instruments.</i>”");

			outputText("\n\nYou intimate that next time you’ll simply draw a giant cock on her face, which does get a laugh from her.");
		}

		private function kellyButtIntro():void
		{
			outputText("You command her to stand perfectly still.  She can’t quite stop clopping her hooves fretfully as you dip your finger into the ink and carefully draw your design on her smooth, brawny horse ass before sealing it on with the paper. ");

			outputText("\n\n“<i>What did you draw, [master]?</i>” she asks tentatively when you’re done. Trying to keep a straight face, you say the word “spank” on one cheek, “me” on the other. “<i>That’s funny, [master]. Ha ha. Y-you didn’t really do that, did you? Ow!</i>” ");

			outputText("\n\nThinking about it now, as you draw your reddened hand away from what is now tattooed on her irresistibly broad, chestnut behind, that was an opportunity lost. ");
		}

		private function smallMilkyButtIntro():void
		{
			outputText("You command her to set herself down across your [legs]. The dusky girl does so, staying perfectly still as you dip your finger into the ink, carefully draw your design on her fine, round ass, and then seal it on with the paper.");
		}

		private function bigMilkyButtIntro():void
		{
			outputText("You set yourself down behind [bathgirlName] before dipping your finger into the ink, carefully draw your design on her fine, round ass, and then seal it on with the paper. She barely seems to notice.");

			outputText("\n\n“<i>Bath time?</i>”");

			outputText("\n\n“<i>Soon,</i>” you reply soothingly, as you turn to go put your branding equipment back.");
		}

		private function tattooMerge():void
		{
			outputText("\n\nAfter you’re done horsing around, Whitney redresses, unable to stop her hand drifting to the new, indelible inscription on her body as she does.");

			outputText("\n\n“<i>I’m glad you like what I’ve gotten you, [master],</i>” she says. “<i>I’ll put it in the barn so if you ever get the urge to, um, mark more cattle, it’s there. Just be warned [master], magic ink ain’t cheap - each mark’ll cost a good 50 gems.</i>”");

			outputText("\n\nYou tell her she’s done very well, before turning and leaving.");

			doNext(13);
		}

		private function tribalTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>You’ve got skilled fingers, [master],</i>” she says, touching what you’ve drawn admiringly. “<i>Although guess I already knew that.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>Does this make me more beautiful to you, [master]?</i>” she says, touching what you’ve drawn admiringly. “<i>If so... it’s exactly what I wanted.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerBackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function jojoTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackTattoo();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bimboSophieTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function vapulaTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>How gauche,</i>” she yawns after you’re done. “<i>I might have to start wearing clothes now.</i>” You can tell by the grin curling her lip and the way she touches the design she’s quietly pleased with it, though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function kellyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("“<i>That’s- that’s actually really pretty, [master]!</i>” Kelly says when you’re done, looking down with delight. “<i>Thank you!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function smallMilkyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>Oh hey, that’s quite pretty.</i>” [bathgirlName] smiles down at what you’ve drawn as you withdraw the pen. “<i>Thanks, [name]!</i>” You kiss her fondly on the forehead and send her on her way.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh…</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bigMilkyTribalTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A tribal tattoo, all snaking, erotic lines, across her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bigMilkyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bigMilkyPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bigMilkyBathToyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Bath Toy” tattooed across her ";

			if (slot == 0)
			{
				bigMilkyCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bigMilkyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bigMilkyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bigMilkyButtIntro();
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bigMilkyMegaMilkTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mega Milk” tattooed across her collarbone.";
			bigMilkyCollarboneIntro();
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;


			doNext(13);
		}

		private function bigMilkyCockCozyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Cozy” tattooed across her collarbone.";
			bigMilkyCollarboneIntro();
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;


			doNext(13);
		}

		private function heartTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>You’ve got skilled fingers, [master],</i>” she says, touching what you’ve drawn admiringly. “<i>Although guess I already knew that.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>Does this make me more beautiful to you, [master]?</i>” she says, touching what you’ve drawn admiringly. “<i>If so... it’s exactly what I wanted.</i>”");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function jojoHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bimboSophieHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function vapulaHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>How gauche,</i>” she yawns after you’re done. “<i>I might have to start wearing clothes now.</i>” You can tell by the grin curling her lip and the way she touches the design she’s quietly pleased with it, though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function kellyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("“<i>That’s- that’s actually really pretty, [master]!</i>” Kelly says when you’re done, looking down with delight. “<i>Thank you!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function smallMilkyHeartTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A plump, red love heart tattoo on her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>Oh hey, that’s quite pretty.</i>” [bathgirlName] smiles down at what you’ve drawn as you withdraw the pen. “<i>Thanks, [name]!</i>” You kiss her fondly on the forehead and send her on her way.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?...</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function smallMilkyPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment colouring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?...</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function smallMilkyBathToyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Bath Toy” tattooed across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();
				outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment colouring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before turning to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?...</i>”");
				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();
				outputText("\n\n“<i>So, uh...</i>” she says when you’re done. “<i>What did you do?</i>” Something much better than a butterfly you say, grinning as you touch the permanent marking before putting her down to go stow the branding gear away.");

				outputText("\n\n“<i>Yes, but what is it? [name]? Hello?</i>”");
				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function smallMilkyMegaMilkTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mega Milk” tattooed across her collarbone.";

			smallMilkyCollarboneIntro();
			outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment colouring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;

			doNext(13);
		}

		private function smallMilkyCockCozyTattoo():void
		{
			clearOutput();

			var tText:String = "“Cock Cozy” tattooed across her collarbone.";

			smallMilkyCollarboneIntro();
			outputText("“<i>[name],</i>” [bathgirlName] groans with laughter, deep embarrassment colouring her tan cheeks as she looks down at what you’ve written. “<i>Everyone can see that!</i>” That’s the whole point you reply, with a rakish grin. She sighs in exasperation as you kiss her fondly on the forehead and take your leave.");
			flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;

			doNext(13);
		}

		private function numMilkyButterflyTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE].indexOf("A butterfly") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS].indexOf("A butterfly") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK].indexOf("A butterfly") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_BUTT].indexOf("A butterfly") >= 0) count++;
			}
			return count;
		}

		private function smallMilkyButterflyTattoo():void
		{
			clearOutput();

			var tText:String = "A butterfly, its four leaf-like wings in flight, tattooed across her ";

			if (slot == 0)
			{
				smallMilkyCollarboneIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\nShe looks down with growing delight as the four winged shape becomes apparent, and then almost completely ruins it by gushing with glee, making her chest quiver, as you add the final red flourishes. Once you’re finished she plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name], that’s beautiful! I can’t wait to show it off to everyone else around here!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, adjusting her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like…</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "collarbone.";
				flags[kFLAGS.MILKY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				smallMilkyShouldersIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\n[bathgirlName]’s back quivers when you trace a four winged shape; she’s worked out what you’re doing. Grinning, you tell her to be still. She still almost ruins it by gushing with glee as you add the final red flourishes. Once you’re finished she immediately gets up and plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name]! I can’t wait to show it off to everyone else around here!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, adjusting her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like…</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "shoulders.";
				flags[kFLAGS.MILKY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				smallMilkyLowerBackIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\n[bathgirlName]’s back quivers when you trace a four winged shape; she’s worked out what you’re doing. Grinning, you tell her to be still, but she almost ruins it by gushing with glee as you add the final red flourishes. Once you’re finished she immediately gets up and plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name]! I can’t wait to show it off to everyone else around here!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, attempting to adjust her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like…</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "lower back.";
				flags[kFLAGS.MILKY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				smallMilkyButtIntro();

				if (numMilkyButterflyTats() < 3)
				{
					outputText("\n\n[bathgirlName]’s back quivers when you trace a four winged shape; she’s worked out what you’re doing. Grinning, you tell her to be still. She still almost ruins it by gushing with glee as you add the final red flourishes. Once you’re finished she immediately gets up and plants a big kiss on your lips.");

					outputText("\n\n“<i>Thank you so much [name]! I can’t wait to show it off to – well, I am so pleased with it, anyway!</i>” You smile as you watch her leave, her fingers trailing over her new butterfly, attempting to adjust her clothes to make the most of it.");
				}
				else
				{
					outputText("\n\n“Oh for...” [bathgirlName] sighs with exasperation as, through long experience, she quickly discerns what you’re drawing. Grinning, you tell her again to be still. “<i>I know I said I liked butterflies [name],</i>” she says when you’re done. “<i>But look at me! They’re crawling all over me, it’s ridiculous. I look like... like…</i>” like you took a bath in butterflies, you suggest, sitting back and drinking in her naked, lepidopteron covered form. And it’s absolutely adorable.");

					outputText("\n\n“<i>I’m going to be very careful about what I say I like to you in future,</i>” she says, visibly struggling to stay angry as she turns herself around and around to admire herself. “<i>I guess - they definitely make me look different, don’t they?</i>” You kiss her fondly on the forehead and send her on her way with a clap on the butterfly.");
				}

				tText += "butt.";
				flags[kFLAGS.MILKY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function kellyHorseshoeTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A horseshoe imprinted firmly on each shoulder.";

			kellyShouldersIntro();
			flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;

			doNext(13);
		}

		private function kellyPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("\n\n“<i>Oh, [master],</i>” Kelly sighs with a mixture of exasperation and shameless lust when you’re done, looking at what you’ve permanently inscribed on her chest. “<i>Did you have to write it quite so large?</i>” You say in a tone of complete reasonableness that you tattoo things relative to the size of the truth behind them, to which she has no answer.");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function kellyNo1FillyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“#1 Filly” tattooed across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("\n\n“<i>Oh, [master],</i>” Kelly sighs with a mixture of exasperation and shameless lust when you’re done, looking at what you’ve permanently inscribed on her chest. “<i>Did you have to write it quite so large?</i>” You say in a tone of complete reasonableness that you tattoo things relative to the size of the truth behind them, to which she has no answer.");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function kellyDickWonTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“I Fought the Dick And the Dick Won” tattooed in fine text across her ";

			if (slot == 0)
			{
				kellyCollarboneIntro();
				outputText("\n\n“<i>Oh, [master],</i>” Kelly sighs with a mixture of exasperation and shameless lust when you’re done, looking at what you’ve permanently inscribed on her chest. “<i>Did you have to write it quite so large?</i>” You say in a tone of complete reasonableness that you tattoo things relative to the size of the truth behind them, to which she has no answer.");
				tText += "collarbone.";
				flags[kFLAGS.KELLY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				kellyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.KELLY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				kellyLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.KELLY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				kellyButtIntro();
				tText += "butt.";
				flags[kFLAGS.KELLY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function propertyTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyPropertyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function jojoPropertyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bimboSophiePropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>F...</i>” she says, looking down and reading aloud. “<i>Fa...wait. Is that a p? P...pro...no wait, I am a silly! It’s an R. Ro...</i>”");

				outputText("\n\nYou leave her to it.");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function vapulaPropertyOfTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Property of [Name]” tattooed across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>Way to state the blindingly obvious, [master],</i>” she sighs with a roll of the eyes after she’s glanced down. You can tell by the grin curling her lip and the way she touches the words the slut is quietly pleased with it though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function vapulaCumAddictTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cum Addict” tattooed across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>Way to state the blindingly obvious, [master],</i>” she sighs with a roll of the eyes after she’s glanced down. You can tell by the grin curling her lip and the way she touches the words the slut is quietly pleased with it though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function vapulaButtslutTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Buttslut” tattooed in a red love heart across her lower back.";

			vapulaLowerBackTattoo();
			tText += "lower back.";
			flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;

			doNext(13);
		}

		private function vapulaDildoPolisherTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Dildo Polisher” tattooed across her ";

			if (slot == 0)
			{
				vapulaCollarboneIntro();
				outputText("\n\n“<i>Way to state the blindingly obvious, [master],</i>” she sighs with a roll of the eyes after she’s glanced down. You can tell by the grin curling her lip and the way she touches the words the slut is quietly pleased with it though.");
				tText += "collarbone.";
				flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				vapulaShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				vapulaLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				vapulaButtIntro();
				tText += "butt.";
				flags[kFLAGS.VAPULA_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bimboSophieSwallowTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "A swallow with its tapering wings in flight across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bimboSophieBreedingBitchTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Breeding Bitch” tattooed across her ";

			if (slot == 0)
			{
				bimboSophieCollarboneIntro();
				outputText("\n\n“<i>Woah,</i>” she says, awed at your drawing. “<i>You are sooooo artsy [name], that’s beautiful! You’ll like do more on me, right?</i>” Laughing, you tell her maybe, if she behaves well for Mistress Whitney and lays plenty of eggs for you. An expression of deepest determination emerges on the harpy’s beautiful features.");

				outputText("\n\n“<i>If it means more super sexy tats I will do my absolute bestest, babe!</i>”");
				tText += "collarbone.";
				flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				bimboSophieShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				bimboSophieLowerBackTattoo();
				tText += "lower back.";
				flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				bimboSophieButtIntro();
				tText += "butt.";
				flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function bimboSophieCockGoesHereTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Goes Here” tattooed across her lower back.";

			bimboSophieLowerBackTattoo();
			flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] = tText;

			doNext(13);
		}

		private function bimboSophieWideLoadTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Wide” tattooed across one butt cheek and “Load” tattooed on the other.";

			bimboSophieButtIntro();
			flags[kFLAGS.SOPHIE_TATTOO_BUTT] = tText;

			doNext(13);
		}

		private function no1Tattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“No. 1 Bitch” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyBreedingBitchTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Breeding Bitch” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function champCocksuckerTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“Champion Cocksucker” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function amilyCockGoesHereTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Goes Here” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function jojoCockGoesHereTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Cock Goes Here” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function amilyMommysGirlTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mommy’s Girl” tattooed across her ";

			if (slot == 0)
			{
				amilyCollarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with a delighted laugh when she looks down at what is now inscribed for all to see on her naked chest.");
				tText += "collarbone.";
				flags[kFLAGS.AMILY_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				amilyShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.AMILY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				amilyLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.AMILY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				amilyButtIntro();
				tText += "butt.";
				flags[kFLAGS.AMILY_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function jojoMommysBoyTattoo(slot:int):void
		{
			clearOutput();

			var tText:String = "“Mommy’s Boy” tattooed across his ";

			if (slot == 0)
			{
				jojoCollarboneIntro();
				tText += "collarbone.";
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = tText;
			}
			else if (slot == 1)
			{
				jojoShouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				jojoLowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				jojoButtIntro();
				tText += "butt.";
				flags[kFLAGS.JOJO_TATTOO_BUTT] = tText;
			}

			doNext(13);
		}

		private function champPussylickerTattoo(slot:int):void
		{
			clearOutput();
			whitneySprite();

			var tText:String = "“Champion Pussylicker” tattooed across her ";

			if (slot == 0)
			{
				collarboneIntro();
				outputText("\n\n“<i>As if I ever need reminding of that, [master],</i>” she says with an exasperated, flustered laugh, when she looks down at what is now inscribed for all to see on her chest.");
				tText += "collarbone.";
				flags[kFLAGS.WHITNEY_TATTOO_COLLARBONE] += tText;
			}
			else if (slot == 1)
			{
				shouldersIntro();
				tText += "shoulders.";
				flags[kFLAGS.WHITNEY_TATTOO_SHOULDERS] = tText;
			}
			else if (slot == 2)
			{
				lowerbackIntro();
				tText += "lower back.";
				flags[kFLAGS.WHITNEY_TATTOO_LOWERBACK] = tText;
			}
			else if (slot == 3)
			{
				buttIntro();
				tText += "butt.";
				flags[kFLAGS.WHITNEY_TATTOO_BUTT] = tText;
			}

			tattooMerge();
		}

		private function dontTestBranding():void
		{
			clearOutput();
			whitneySprite();

			outputText("Maybe later, you say. Whitney looks disappointed.");

			outputText("\n\n“<i>Fine. I’ll put it in the barn so if you ever get the urge to, um, mark some cattle, it’s there. Be warned though [master], that ink ain’t cheap- each mark’ll cost 50 gems.</i>”");

			outputText("\n\nYou tell her she’s done very well, before turning and leaving.");

			doNext(13);
		}

		private function numAmilyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.AMILY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.AMILY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function amilyFullTribalTats():Boolean
		{
			if (numAmilyTribalTats() == 4) return true;
			return false;
		}

		private function numJojoTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.JOJO_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.JOJO_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function jojoFullTribalTats():Boolean
		{
			if (numJojoTribalTats() == 4) return true;
			return false;
		}

		private function numSophieTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.SOPHIE_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.SOPHIE_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function sophieFullTribalTats():Boolean
		{
			if (numSophieTribalTats() == 4) return true;
			return false;
		}

		private function numVapulaTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.VAPULA_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.VAPULA_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function vapulaFullTribalTats():Boolean
		{
			if (numVapulaTribalTats() == 4) return true;
			return false;
		}

		private function numKellyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.KELLY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.KELLY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function kellyFullTribalTats():Boolean
		{
			if (numKellyTribalTats() == 4) return true;
			return false;
		}

		private function numMilkyTribalTats():int
		{
			var count:int = 0;
			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK].indexOf("A tribal tattoo") >= 0) count++;
			}
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] is String)
			{
				if (flags[kFLAGS.MILKY_TATTOO_BUTT].indexOf("A tribal tattoo") >= 0) count++;
			}
			return count;
		}

		public function milkyFullTribalTats():Boolean
		{
			if (numMilkyTribalTats() == 4) return true;
			return false;
		}
	}

}