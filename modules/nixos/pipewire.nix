{ lib, config, pkgs, ... }:
let
	noise-reduction = {
		"context.properties"."default.clock.rate" = 48000;
		"context.modules" = [{
			name = "libpipewire-module-filter-chain";
			args = {
				"node.description" = "Noise Cancelling Source";
				"media.name" = "Noise Cancelling Source";
				"filter.graph" = {
					nodes = [{
						type = "ladspa";
						name = "rnnoise";
						plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
						label = "noise_suppressor_mono";
						control = {
							"VAD Threshold (%)" = 50.0;
							"VAD Grace Period (ms)" = 200;
							"Retroactive VAD Grace (ms)" = 0;
						};
					}];
				};
				"audio.position" = [ "FL" "FR" ];
				"capture.props" = {
					"node.name" = "capture.rnnoise_source";
					"node.passive" = true;
					"audio.rate" = 48000;
				};
				"playback.props" = {
					"node.name" =  "rnnoise_source";
					"media.class" = "Audio/Source";
					"audio.rate" = 48000;
				};
			};
		}];
	};

	low-latency = {
		context.properties = {
			default.clock.rate = 48000;
			default.clock.quantum = 32;
			default.clock.min-quantum = 32;
			default.clock.max-quantum = 32;
		};
	};
in
{
	options.pipewire = {
		enable = lib.mkEnableOption "Enable pipewire module";

		enableNoiseReduction = lib.mkOption {
			description = "Whether to enable noise reduction plugin for pipewire.";
			type = lib.types.bool;
			default = true;
		};

		enableLowLatency = lib.mkOption {
			description = "Whether to enable low latency plugin for pipewire.";
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.pipewire.enable {
		services.pipewire = {
			enable = true;
			alsa = {
				enable = true;
				support32Bit = true;
			};
			pulse.enable = true;
			# If you want to use JACK applications, uncomment this
			#jack.enable = true;

			# use the example session manager (no others are packaged yet so this is enabled by default,
			# no need to redefine it in your config for now)
			#media-session.enable = true;

			extraConfig.pipewire = {
				"92-low-latency" = lib.mkIf config.pipewire.enableLowLatency low-latency;
				"99-noise-supression" = lib.mkIf config.pipewire.enableNoiseReduction noise-reduction;
			};
		};
	};
}
