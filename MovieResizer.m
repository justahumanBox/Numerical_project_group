function outputFullFileName = MovieResizer(inputFullFileName, outputVideoRows, outputVideoColumns)
%將輸入的影片重塑成指定大小輸出
% 輸入檔案的名字，與指定的x, y大小，即會自動輸出附有_resized檔名的影片檔，並輸出檔名

fontSize = 22;
inputVideoReaderObject = VideoReader(inputFullFileName);
numberOfFrames = inputVideoReaderObject.NumFrames;

dotPosition = strfind(inputFullFileName, '.');
rawFileName = inputFullFileName(1:dotPosition-1);
extensionType = inputFullFileName(dotPosition:length(inputFullFileName));

outputFullFileName = strcat(rawFileName, '_resized', extensionType);
outputVideoWriterObject = VideoWriter(outputFullFileName);
outputVideoWriterObject.FrameRate = inputVideoReaderObject.FrameRate;

open(outputVideoWriterObject);

numberOfFramesWritten = 0;
figure(91);
set(gcf, 'units','normalized','outerposition',[0.2 0.2 0.3 0.5]);

for frame = 1 : numberOfFrames
	thisInputFrame = read(inputVideoReaderObject, frame);
	
	image(thisInputFrame);
	axis off;
    axis image;
    caption = sprintf('Frame %4d of %d.', frame, numberOfFrames);
    title(caption, 'FontSize', fontSize);
    drawnow;
    
    outputFrame = imresize(thisInputFrame, [outputVideoRows, outputVideoColumns]);
    
    writeVideo(outputVideoWriterObject, outputFrame);
    
%     fprintf('Processed frame %4d of %d.\n', frame, numberOfFrames);
    
    numberOfFramesWritten = numberOfFramesWritten + 1;
    
end

close(91);
close(outputVideoWriterObject);

end

