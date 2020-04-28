export default function (filename, text) {
  let element = document.createElement('a');
  element.setAttribute('href', 'data:image/svg+xml;utf8,' + encodeURIComponent(text));
  element.setAttribute('download', filename);

  element.style.display = 'none';
  document.body.appendChild(element);

  element.click();

  document.body.removeChild(element);
}