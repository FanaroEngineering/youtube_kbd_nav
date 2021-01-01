import 'dart:html' show DivElement, document;
import 'dart:svg' show SvgSvgElement;

import 'package:meta/meta.dart' show immutable;

@immutable
class Logo {
  static const String _id = 'youtube-kbd-nav-logo',
      _svgHtml = '''
    <svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 109.13 76.89">
      <defs>
        <style>
          .cls-1{fill:#ed2024;}.cls-2{fill:#fff;}
        </style>
      </defs>
      <path class="cls-1" d="M106.85,12A13.68,13.68,0,0,0,97.2,2.3C88.69,0,54.57,0,54.57,0S20.44,0,11.93,2.3A13.7,13.7,0,0,0,2.28,12C0,20.57,0,38.44,0,38.44S0,56.32,2.28,64.88a13.7,13.7,0,0,0,9.65,9.71c8.51,2.3,42.64,2.3,42.64,2.3s34.12,0,42.63-2.3a13.68,13.68,0,0,0,9.65-9.71c2.28-8.56,2.28-26.44,2.28-26.44s0-17.87-2.28-26.43Z" />
      <path class="cls-2" d="M17.87,15.23A4.86,4.86,0,0,0,13,20.1V56.79a4.87,4.87,0,0,0,4.86,4.87H91.25a4.88,4.88,0,0,0,4.87-4.87V20.1a4.87,4.87,0,0,0-4.87-4.87ZM91.25,56.79H17.87V20.1H91.25C91.26,57.62,91.27,56.79,91.25,56.79Z" />
      <path class="cls-2" d="M28.61,46.4H26.08a2.48,2.48,0,0,0-2.49,2.16A2.44,2.44,0,0,0,26,51.27h2.53A2.49,2.49,0,0,0,31,49.11,2.43,2.43,0,0,0,28.61,46.4Z" />
      <path class="cls-2" d="M35,36H32.57a2.46,2.46,0,0,0-2.48,2.16,2.43,2.43,0,0,0,2.42,2.71H35.1a2.44,2.44,0,0,0,2.42-2.71A2.46,2.46,0,0,0,35,36Z" />
      <path class="cls-2" d="M45.56,40.88H48a2.48,2.48,0,0,0,2.48-2.16A2.43,2.43,0,0,0,48.09,36h-2.6a2.44,2.44,0,0,0-2.42,2.71A2.49,2.49,0,0,0,45.56,40.88Z" />
      <path class="cls-2" d="M58.54,40.88H61a2.49,2.49,0,0,0,2.49-2.16A2.44,2.44,0,0,0,61.08,36h-2.6a2.43,2.43,0,0,0-2.42,2.71A2.48,2.48,0,0,0,58.54,40.88Z" />
      <path class="cls-2" d="M74.06,36H71.53a2.46,2.46,0,0,0-2.48,2.16,2.43,2.43,0,0,0,2.42,2.71H74a2.47,2.47,0,0,0,2.48-2.16A2.43,2.43,0,0,0,74.06,36Z" />
      <path class="cls-2" d="M80.49,25.62H78a2.47,2.47,0,0,0-2.48,2.16A2.43,2.43,0,0,0,78,30.49h2.6A2.44,2.44,0,0,0,83,27.78,2.48,2.48,0,0,0,80.49,25.62Z" />
      <path class="cls-2" d="M65,30.49h2.54A2.48,2.48,0,0,0,70,28.33a2.43,2.43,0,0,0-2.42-2.71H65a2.48,2.48,0,0,0-2.49,2.16A2.44,2.44,0,0,0,65,30.49Z" />
      <path class="cls-2" d="M52,30.49h2.53A2.47,2.47,0,0,0,57,28.33a2.43,2.43,0,0,0-2.42-2.71H52.05a2.46,2.46,0,0,0-2.48,2.16A2.43,2.43,0,0,0,52,30.49Z" />
      <path class="cls-2" d="M39,30.49h2.53A2.49,2.49,0,0,0,44,28.33a2.44,2.44,0,0,0-2.42-2.71H39.06a2.47,2.47,0,0,0-2.48,2.16A2.43,2.43,0,0,0,39,30.49Z" />
      <path class="cls-2" d="M26,30.49h2.53A2.49,2.49,0,0,0,31,28.33a2.43,2.43,0,0,0-2.42-2.71H26.08a2.48,2.48,0,0,0-2.49,2.16A2.44,2.44,0,0,0,26,30.49Z" />
      <path class="cls-2" d="M83.15,46.4H80.62a2.46,2.46,0,0,0-2.48,2.16,2.44,2.44,0,0,0,2.42,2.71h2.53a2.47,2.47,0,0,0,2.48-2.16A2.43,2.43,0,0,0,83.15,46.4Z" />
      <path class="cls-2" d="M70.17,46.4H39.06a2.47,2.47,0,0,0-2.48,2.16A2.44,2.44,0,0,0,39,51.27H70.1a2.49,2.49,0,0,0,2.49-2.16A2.44,2.44,0,0,0,70.17,46.4Z" />
    </svg>
  ''';

  const Logo();

  void _insert() {
    final DivElement youtubeLogoDiv = document.querySelector('div#start');

    final SvgSvgElement svgSvgElement = SvgSvgElement();
    svgSvgElement.innerHtml = _svgHtml;
    svgSvgElement.id = _id;
    svgSvgElement.style.height = "24";
    svgSvgElement.style.width = "40";

    youtubeLogoDiv.append(svgSvgElement);
  }

  void toggle() {
    final SvgSvgElement extractedLogo = document.querySelector('#' + _id);
    extractedLogo == null ? _insert() : extractedLogo.remove();
  }
}
