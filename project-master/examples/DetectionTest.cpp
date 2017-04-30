#include "AprilTagInterface.hpp"

using namespace std;

int main()
{
    AprilTagInterface april;
    while (true)
    {
        april.processFrame();
        tagFrame frame = april.getFrame();
        if (!frame.empty())
        {
            for( tagFrame::iterator it = frame.begin(); it != frame.end(); it++)
            {
                cout << "Tag id " << it->id << " detected at: (" << it->pos_x << ", " << it->pos_y << ", " << it->pos_z << ")" << endl;
            }
        }
    }
}
